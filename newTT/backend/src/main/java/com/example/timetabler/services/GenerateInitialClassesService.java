package com.example.timetabler.services;

import com.example.timetabler.entities.*;
import com.example.timetabler.entities.enums.SessionType;
import com.example.timetabler.repositories.*;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class GenerateInitialClassesService {

    private final SubjectRepository subjectRepo;
    private final SemesterRepository semesterRepo;
    private final DivisionRepository divisionRepo;
    private final BatchRepository batchRepo;
    private final ScheduledClassRepository scheduledClassRepo;
    private final TeacherSubjectAllocationRepository teacherSubjectAllocationRepo;
    private final ElectiveDivisionRepository electiveDivisionRepo;
    private final TimeSlotRepository timeSlotRepo;

    /* ================= COMMON HELPERS ================= */

    private Set<Integer> getSemesterNumbers(String mode) {
        return mode.equalsIgnoreCase("EVEN")
                ? Set.of(4, 6, 8)
                : Set.of(3, 5, 7);
    }

    private void cleanScheduledClasses() {
        scheduledClassRepo.deleteAll();
        scheduledClassRepo.flush();
    }

    /* =========================================================
       PHASE 1 : ELECTIVES (FROM elective_division – FINAL & CORRECT)
       ========================================================= */
    @Transactional
    public int insertElectivesFromElectiveDivision(String mode) {

        int rows = 0;
        Set<Integer> semNums = getSemesterNumbers(mode);

        for (Object[] r : electiveDivisionRepo.findUniqueParentSemesterSlot()) {

            Long subjectId = (Long) r[0];
            Long semId     = (Long) r[1];
            Long slotId    = (Long) r[2];

            Semester sem = semesterRepo.getReferenceById(semId);
            if (!semNums.contains(sem.getNumber())) continue;

            ScheduledClass sc = new ScheduledClass();
            sc.setSubject(subjectRepo.getReferenceById(subjectId));
            sc.setSemester(sem);
            sc.setTimeSlot(timeSlotRepo.getReferenceById(slotId));
            sc.setSessionType(SessionType.ELECTIVE);
            sc.setElectiveFlag(1);
            sc.setPinned(true);

            sc.setTeacherSubjectAllocation(null);
            sc.setClassroom(null);
            sc.setDivision(null);
            sc.setBatch(null);

            scheduledClassRepo.save(sc);
            rows++;
        }

        return rows;
    }

    /* =========================================================
       PHASE 2 : NON-ELECTIVES
       ========================================================= */
    @Transactional
    public void generateInitialClasses(String mode) {

        int rows = 0;
        Set<Integer> semNums = getSemesterNumbers(mode);

        /* 🔥 CLEAN */
        cleanScheduledClasses();

        /* 🔥 ELECTIVES FIRST (PARENT, FIXED) */
        int electiveRows = insertElectivesFromElectiveDivision(mode);

        for (Subject subject : subjectRepo.findAll()) {

            if (subject.isElective()) continue;
            if (!semNums.contains(subject.getSemester().getNumber())) continue;

            if (teacherSubjectAllocationRepo
                    .findBySubject_Id(subject.getId()).isEmpty())
                continue;

            List<Division> divisions =
                    divisionRepo.findBySemesterId(
                            subject.getSemester().getId());

            /* ================= LECTURES ================= */
            for (Division division : divisions) {
                for (int i = 0; i < subject.getWeeklyLectureHours(); i++) {

                    ScheduledClass sc = new ScheduledClass();
                    sc.setSubject(subject);
                    sc.setSemester(subject.getSemester());
                    sc.setDivision(division);
                    sc.setBatch(null);
                    sc.setSessionType(SessionType.LEC);

                    sc.setTimeSlot(null);
                    sc.setClassroom(null);
                    sc.setTeacherSubjectAllocation(null);

                    sc.setElectiveFlag(0);
                    sc.setPinned(false);

                    scheduledClassRepo.save(sc);
                    rows++;
                }
            }

            /* ================= TUTORIALS ================= */
            if (subject.getWeeklyTutorialHours() > 0) {
                for (Division division : divisions) {
                    for (Batch batch :
                            batchRepo.findByDivisionId(division.getId())) {

                        for (int i = 0;
                             i < subject.getWeeklyTutorialHours(); i++) {

                            ScheduledClass sc = new ScheduledClass();
                            sc.setSubject(subject);
                            sc.setSemester(subject.getSemester());
                            sc.setDivision(division);
                            sc.setBatch(batch);
                            sc.setSessionType(SessionType.TUT);

                            sc.setTimeSlot(null);
                            sc.setClassroom(null);
                            sc.setTeacherSubjectAllocation(null);

                            sc.setElectiveFlag(0);
                            sc.setPinned(false);

                            scheduledClassRepo.save(sc);
                            rows++;
                        }
                    }
                }
            }

            /* ================= LABS ================= */
            if (subject.getWeeklyLabHours() > 0) {
                for (Division division : divisions) {
                    for (Batch batch :
                            batchRepo.findByDivisionId(division.getId())) {

                        ScheduledClass sc = new ScheduledClass();
                        sc.setSubject(subject);
                        sc.setSemester(subject.getSemester());
                        sc.setDivision(division);
                        sc.setBatch(batch);
                        sc.setSessionType(SessionType.LAB);

                        sc.setTimeSlot(null);
                        sc.setClassroom(null);
                        sc.setTeacherSubjectAllocation(null);

                        sc.setElectiveFlag(0);
                        sc.setPinned(false);

                        scheduledClassRepo.save(sc);
                        rows++;
                    }
                }
            }
        }

        System.out.println(
                "Electives inserted = " + electiveRows +
                ", Non-electives inserted = " + rows
        );
    }
}
