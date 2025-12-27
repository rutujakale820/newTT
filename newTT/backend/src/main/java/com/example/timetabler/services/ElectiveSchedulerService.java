package com.example.timetabler.services;

import com.example.timetabler.entities.*;
import com.example.timetabler.entities.enums.RoomType;
import com.example.timetabler.entities.enums.SlotType;
import com.example.timetabler.repositories.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class ElectiveSchedulerService {

    // Hard caps (initial split)
    private static final int LEC_CAPACITY = 80;
    private static final int LAB_CAPACITY = 25;

    // “small” threshold
    private static final int MIN_LEC = 10;
    private static final int MIN_LAB = 5;

    // Soft cap (merge to remove singles)
    private static final int LEC_MERGE_MAX = 90; // requested
    private static final int LAB_MERGE_MAX = 25;

    private final StudentElectiveChoiceRepository studentChoiceRepo;
    private final ElectiveOptionRepository electiveOptionRepo;
    private final ElectiveDivisionRepository electiveDivisionRepo;
    private final ClassroomRepository classroomRepo;
    private final TimeSlotRepository timeSlotRepo;
    private final SemesterRepository semesterRepo;
    private final EquiTimeSlotRepository equiTimeSlotRepo;

    /* ===================================================== */

    public void generateElectives(String mode) {

        List<Integer> semesters =
                mode.equalsIgnoreCase("EVEN")
                        ? List.of(2, 4, 6, 8)
                        : List.of(1, 3, 5, 7);

        electiveDivisionRepo.deleteAll();

        for (Integer semNo : semesters) {
            semesterRepo.findByNumber(semNo)
                    .ifPresent(this::generateForSemester);
        }
    }

    private void generateForSemester(Semester semester) {

        List<ElectiveGroupOption> options =
                studentChoiceRepo.findChosenOptionsBySemester(semester.getId());

        Map<Subject, List<ElectiveGroupOption>> byParent =
                options.stream()
                        .collect(Collectors.groupingBy(o -> o.getElectiveGroup().getParentSubject()));

        Set<Long> semesterBlockedSlots = new HashSet<>();

        for (var entry : byParent.entrySet()) {
            scheduleParent(entry.getKey(), entry.getValue(), semester, semesterBlockedSlots);
        }

        mergeSmallDivisions(semester);
    }

    private void scheduleParent(
            Subject parent,
            List<ElectiveGroupOption> options,
            Semester semester,
            Set<Long> semesterBlockedSlots
    ) {
        scheduleLectures(parent, options, semester, semesterBlockedSlots);
        scheduleLabs(parent, options, semester, semesterBlockedSlots);
    }

    /* =================== CONFLICT HELPERS =================== */

    // Teacher cannot repeat in slot OR any equi slot (global across semesters)
    private boolean teacherBusyInSlotOrEqui(Long teacherId, Long slotId) {

        if (teacherId == null || slotId == null) return false;

        Set<Long> conflictSlots = new HashSet<>();
        conflictSlots.add(slotId);

        // If slot is LAB, add mapped LEC(s)
        equiTimeSlotRepo.findByLabSlot(slotId)
                .forEach(eq -> conflictSlots.add(eq.getLecSlot()));

        // If slot is LEC, add mapped LAB(s)
        equiTimeSlotRepo.findByLecSlot(slotId)
                .forEach(eq -> conflictSlots.add(eq.getLabSlot()));

        return electiveDivisionRepo.existsByTeacherIdAndTimeSlotIdIn(teacherId, conflictSlots);
    }

    private boolean roomBusyGlobal(Long classroomId, Long slotId) {
        if (classroomId == null || slotId == null) return false;
        return electiveDivisionRepo.existsByClassroomIdAndTimeSlotId(classroomId, slotId);
    }

    /* ======================= LECTURES ===================== */

    private void scheduleLectures(
            Subject parent,
            List<ElectiveGroupOption> options,
            Semester semester,
            Set<Long> semesterBlockedSlots
    ) {

        int lecHours = Optional.ofNullable(parent.getWeeklyLectureHours()).orElse(0);
        if (lecHours <= 0) return;

        List<TimeSlot> lecSlots = timeSlotRepo.findSlotsBySlotType(SlotType.LEC);

        Map<Integer, List<TimeSlot>> byDay =
                lecSlots.stream().collect(Collectors.groupingBy(TimeSlot::getDayOfWeek));

        List<Integer> days = new ArrayList<>(byDay.keySet());
        Collections.sort(days);

        int rotate = 0;

        for (int lecNo = 1; lecNo <= lecHours; lecNo++) {

            final int lecNoFinal = lecNo;

            boolean placedLectureHour = false;

            for (int d = 0; d < days.size() && !placedLectureHour; d++) {

                Integer day = days.get((rotate + d) % days.size());

                for (TimeSlot slot : byDay.getOrDefault(day, List.of())) {

                    if (semesterBlockedSlots.contains(slot.getId())) continue;

                    // room unique within this slot attempt (across all options)
                    Set<Long> usedRoomsInThisSlot = new HashSet<>();

                    // ✅ teacher unique per option within this slot attempt
                    Map<Long, Set<Long>> usedTeachersByOptionInThisSlot = new HashMap<>();

                    boolean okForAllOptions = true;

                    for (ElectiveGroupOption opt : options) {

                        int total = studentChoiceRepo.findTotalStudentsForOption(opt.getId());
                        if (total <= 0) continue;

                        int divs = (int) Math.ceil((double) total / LEC_CAPACITY);

                        List<Teacher> teachers = electiveOptionRepo.findTeachersByOptionId(opt.getId());
                        if (teachers == null) teachers = List.of();

                        Set<Long> usedTeachersForThisOption =
                                usedTeachersByOptionInThisSlot.computeIfAbsent(opt.getId(), k -> new HashSet<>());

                        // ✅ DIVISION-FIRST LOOP (fix for ACE-L1-1 & ACE-L1-2 same teacher)
                        for (int divIndex = 0; divIndex < divs; divIndex++) {

                            boolean placedDiv = false;

                            for (Teacher t : teachers) {

                                if (t == null) continue;

                                // same option + same slot: teacher cannot repeat
                                if (usedTeachersForThisOption.contains(t.getId())) continue;

                                // global teacher clash: slot + equi slots (across all semesters)
                                if (teacherBusyInSlotOrEqui(t.getId(), slot.getId())) continue;

                                List<Classroom> rooms =
                                        classroomRepo.findFreeClassroomsForSlot(
                                                slot.getId(), RoomType.LEC, semester.getId()
                                        );

                                for (Classroom r : rooms) {

                                    if (r == null) continue;
                                    if (usedRoomsInThisSlot.contains(r.getId())) continue;

                                    if (roomBusyGlobal(r.getId(), slot.getId())) continue;

                                    int remaining = total - (divIndex * LEC_CAPACITY);
                                    int strength = Math.min(LEC_CAPACITY, remaining);

                                    electiveDivisionRepo.save(
                                            ElectiveDivision.builder()
                                                    .semester(semester)
                                                    .parentElective(parent)
                                                    .electiveOption(opt)
                                                    .electiveDivCode(opt.getShortName() + "-L" + lecNoFinal + "-" + (divIndex + 1))
                                                    .studentCount(strength)
                                                    .teacher(t)
                                                    .classroom(r)
                                                    .timeSlot(slot)
                                                    .build()
                                    );

                                    usedTeachersForThisOption.add(t.getId());
                                    usedRoomsInThisSlot.add(r.getId());
                                    placedDiv = true;
                                    break;
                                }

                                if (placedDiv) break;
                            }

                            if (!placedDiv) {
                                okForAllOptions = false;
                                break;
                            }
                        }

                        if (!okForAllOptions) break;
                    }

                    if (okForAllOptions) {
                        semesterBlockedSlots.add(slot.getId());
                        rotate = (rotate + d + 1) % days.size();
                        placedLectureHour = true;
                        break;
                    } else {
                        // rollback partial created for this parent+slot+lecNo attempt
                        electiveDivisionRepo.deleteAll(
                                electiveDivisionRepo.findBySemesterId(semester.getId()).stream()
                                        .filter(ed -> ed.getTimeSlot() != null && ed.getTimeSlot().getId().equals(slot.getId()))
                                        .filter(ed -> ed.getParentElective() != null && ed.getParentElective().getId().equals(parent.getId()))
                                        .filter(ed -> ed.getElectiveDivCode() != null && ed.getElectiveDivCode().contains("-L" + lecNoFinal))
                                        .toList()
                        );
                    }
                }
            }

            if (!placedLectureHour) {
                throw new RuntimeException("No LEC slot for parent_elective_id=" + parent.getId());
            }
        }
    }

    /* ======================== LABS ========================= */

    private void scheduleLabs(
            Subject parent,
            List<ElectiveGroupOption> options,
            Semester semester,
            Set<Long> semesterBlockedSlots
    ) {

        int labHours = Optional.ofNullable(parent.getWeeklyLabHours()).orElse(0);
        if (labHours <= 0) return;

        List<TimeSlot> labSlots = timeSlotRepo.findSlotsBySlotType(SlotType.LAB);

        TimeSlot chosenLabSlot = null;

        for (TimeSlot slot : labSlots) {

            if (semesterBlockedSlots.contains(slot.getId())) continue;

            boolean lecBlocked =
                    equiTimeSlotRepo.findByLabSlot(slot.getId())
                            .stream()
                            .anyMatch(eq -> semesterBlockedSlots.contains(eq.getLecSlot()));

            if (lecBlocked) continue;

            chosenLabSlot = slot;
            break;
        }

        if (chosenLabSlot == null) {
            throw new RuntimeException("No LAB slot for parent_elective_id=" + parent.getId());
        }

        // lock lab slot + equi lec slots for this semester
        semesterBlockedSlots.add(chosenLabSlot.getId());
        equiTimeSlotRepo.findByLabSlot(chosenLabSlot.getId())
                .forEach(eq -> semesterBlockedSlots.add(eq.getLecSlot()));

        Set<Long> usedTeachersInLabSlot = new HashSet<>();
        Set<Long> usedLabsInLabSlot = new HashSet<>();

        for (ElectiveGroupOption opt : options) {

            int total = studentChoiceRepo.findTotalStudentsForOption(opt.getId());
            if (total <= 0) continue;

            int divs = (int) Math.ceil((double) total / LAB_CAPACITY);

            List<Teacher> teachers = electiveOptionRepo.findTeachersByOptionId(opt.getId());
            if (teachers == null) teachers = List.of();

            for (int divIndex = 0; divIndex < divs; divIndex++) {

                boolean placed = false;

                int remaining = total - (divIndex * LAB_CAPACITY);
                int strength = Math.min(LAB_CAPACITY, remaining);

                for (Teacher t : teachers) {

                    if (t == null) continue;
                    if (usedTeachersInLabSlot.contains(t.getId())) continue;

                    // global clash lab slot + equi lec slots
                    if (teacherBusyInSlotOrEqui(t.getId(), chosenLabSlot.getId())) continue;

                    List<Classroom> labs =
                            classroomRepo.findFreeClassroomsForSlot(
                                    chosenLabSlot.getId(), RoomType.LAB, semester.getId()
                            );

                    for (Classroom lab : labs) {

                        if (lab == null) continue;
                        if (usedLabsInLabSlot.contains(lab.getId())) continue;

                        if (roomBusyGlobal(lab.getId(), chosenLabSlot.getId())) continue;

                        electiveDivisionRepo.save(
                                ElectiveDivision.builder()
                                        .semester(semester)
                                        .parentElective(parent)
                                        .electiveOption(opt)
                                        .electiveDivCode(opt.getShortName() + "-LAB" + (char) ('A' + divIndex))
                                        .studentCount(strength)
                                        .teacher(t)
                                        .classroom(lab)
                                        .timeSlot(chosenLabSlot)
                                        .build()
                        );

                        usedTeachersInLabSlot.add(t.getId());
                        usedLabsInLabSlot.add(lab.getId());
                        placed = true;
                        break;
                    }

                    if (placed) break;
                }

                if (!placed) {
                    throw new RuntimeException("No LAB teacher/classroom for option=" + opt.getId());
                }
            }
        }
    }

    /* ==================== MERGE SMALL ====================== */

    private void mergeSmallDivisions(Semester semester) {

        List<ElectiveDivision> all =
                electiveDivisionRepo.findBySemesterId(semester.getId());

        // ---------- LECTURES ----------
        Map<String, List<ElectiveDivision>> lecGroups =
                all.stream()
                        .filter(d -> d.getTimeSlot() != null && d.getTimeSlot().getSlotType() == SlotType.LEC)
                        .filter(d -> extractLecHourKey(d.getElectiveDivCode()) != null)
                        .collect(Collectors.groupingBy(d ->
                                d.getParentElective().getId()
                                        + "-" + d.getElectiveOption().getId()
                                        + "-" + extractLecHourKey(d.getElectiveDivCode())
                        ));

        for (List<ElectiveDivision> group : lecGroups.values()) {

            List<ElectiveDivision> working =
                    group.stream()
                            .sorted(Comparator.comparingInt(ElectiveDivision::getStudentCount))
                            .collect(Collectors.toList());

            boolean mergedSomething;
            do {
                mergedSomething = false;

                ElectiveDivision small = working.stream()
                        .filter(d -> d.getStudentCount() < MIN_LEC)
                        .min(Comparator.comparingInt(ElectiveDivision::getStudentCount))
                        .orElse(null);

                if (small == null) break;

                ElectiveDivision target =
                        working.stream()
                                .filter(d -> !Objects.equals(d.getId(), small.getId()))
                                .filter(d -> d.getStudentCount() + small.getStudentCount() <= LEC_MERGE_MAX)
                                .max(Comparator.comparingInt(ElectiveDivision::getStudentCount))
                                .orElse(null);

                if (target == null) break;

                target.setStudentCount(target.getStudentCount() + small.getStudentCount());
                electiveDivisionRepo.save(target);
                electiveDivisionRepo.delete(small);

                working.remove(small);
                mergedSomething = true;

            } while (mergedSomething);
        }

        // ---------- LABS ----------
        Map<String, List<ElectiveDivision>> labGroups =
                all.stream()
                        .filter(d -> d.getTimeSlot() != null && d.getTimeSlot().getSlotType() == SlotType.LAB)
                        .collect(Collectors.groupingBy(d ->
                                d.getParentElective().getId() + "-" + d.getElectiveOption().getId()
                        ));

        for (List<ElectiveDivision> group : labGroups.values()) {

            List<ElectiveDivision> working =
                    group.stream()
                            .sorted(Comparator.comparingInt(ElectiveDivision::getStudentCount))
                            .collect(Collectors.toList());

            boolean mergedSomething;
            do {
                mergedSomething = false;

                ElectiveDivision small = working.stream()
                        .filter(d -> d.getStudentCount() < MIN_LAB)
                        .min(Comparator.comparingInt(ElectiveDivision::getStudentCount))
                        .orElse(null);

                if (small == null) break;

                ElectiveDivision target =
                        working.stream()
                                .filter(d -> !Objects.equals(d.getId(), small.getId()))
                                .filter(d -> d.getStudentCount() + small.getStudentCount() <= LAB_MERGE_MAX)
                                .max(Comparator.comparingInt(ElectiveDivision::getStudentCount))
                                .orElse(null);

                if (target == null) break;

                target.setStudentCount(target.getStudentCount() + small.getStudentCount());
                electiveDivisionRepo.save(target);
                electiveDivisionRepo.delete(small);

                working.remove(small);
                mergedSomething = true;

            } while (mergedSomething);
        }
    }

    private String extractLecHourKey(String divCode) {
        if (divCode == null) return null;
        int idx = divCode.indexOf("-L");
        if (idx < 0) return null;
        int start = idx + 1;
        int end = divCode.indexOf("-", start);
        if (end < 0) end = divCode.length();
        return divCode.substring(start, end); // "L1"
    }
}
