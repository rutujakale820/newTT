package com.example.timetabler.services;

import com.example.timetabler.entities.*;
import com.example.timetabler.entities.enums.SlotType;
import com.example.timetabler.entities.enums.RoomType;
import com.example.timetabler.optaplanner.TimetableSolver;
import com.example.timetabler.optaplanner.facts.SlotBlock;          // 🔥 ADD
import com.example.timetabler.optaplanner.facts.SlotBlockBuilder;  // 🔥 ADD
import com.example.timetabler.repositories.*;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.optaplanner.core.api.solver.Solver;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SchedulerService {

    private final ScheduledClassRepository scheduledClassRepository;
    private final TimeSlotRepository timeSlotRepository;
    private final ClassroomRepository classroomRepository;
    private final TeacherSubjectAllocationRepository tsaRepository;
    private final EquiTimeSlotRepository equiTimeSlotRepository;

    private final SlotBlockBuilder slotBlockBuilder;   // 🔥 ADD

    @Transactional
    public void solve(String mode, int secondsLimit) {

        /* =======================
           1️⃣ SEM FILTER
           ======================= */
        Set<Integer> semSet =
                mode.equalsIgnoreCase("EVEN")
                        ? Set.of(4, 6, 8)
                        : Set.of(3, 5, 7);

        /* =======================
           2️⃣ FETCH NON-ELECTIVES
           ======================= */
        List<ScheduledClass> nonElectives =
                scheduledClassRepository.findAll()
                        .stream()
                        .filter(sc ->
                                sc.getElectiveFlag() == 0 &&
                                semSet.contains(
                                        sc.getSemester().getNumber()
                                )
                        )
                        .toList();

        if (nonElectives.isEmpty()) {
            throw new IllegalStateException("❌ No NON-ELECTIVE classes found");
        }

        /* =======================
           3️⃣ SPLIT TIME SLOTS
           ======================= */
        List<TimeSlot> allSlots = timeSlotRepository.findAll();

        List<TimeSlot> lecSlots =
                allSlots.stream()
                        .filter(ts -> ts.getSlotType() == SlotType.LEC)
                        .toList();

        List<TimeSlot> labSlots =
                allSlots.stream()
                        .filter(ts -> ts.getSlotType() == SlotType.LAB)
                        .toList();

        if (lecSlots.isEmpty() || labSlots.isEmpty()) {
            throw new IllegalStateException("❌ LEC/LAB slots missing");
        }

        /* =======================
           4️⃣ SPLIT CLASSROOMS
           ======================= */
        List<Classroom> allRooms = classroomRepository.findAll();

        List<Classroom> lecRooms =
                allRooms.stream()
                        .filter(r -> r.getRoomType() == RoomType.LEC)
                        .toList();

        List<Classroom> labRooms =
                allRooms.stream()
                        .filter(r -> r.getRoomType() == RoomType.LAB)
                        .toList();

        if (lecRooms.isEmpty() || labRooms.isEmpty()) {
            throw new IllegalStateException("❌ LEC/LAB classrooms missing");
        }

        /* =======================
           5️⃣ BUILD SUBJECT → TSA MAP
           ======================= */
        List<TeacherSubjectAllocation> allTsa =
                tsaRepository.findAll();

        Map<Long, List<TeacherSubjectAllocation>> subjectTsaMap =
                allTsa.stream()
                        .collect(Collectors.groupingBy(
                                tsa -> tsa.getSubject().getId()
                        ));

        /* =======================
           6️⃣ INJECT allowedTsa
           ======================= */
        for (ScheduledClass sc : nonElectives) {

            Long subjectId = sc.getSubject().getId();
            List<TeacherSubjectAllocation> allowed =
                    subjectTsaMap.get(subjectId);

            if (allowed == null || allowed.isEmpty()) {
                throw new IllegalStateException(
                        "❌ No TSA mapped for subject " + subjectId
                );
            }

            sc.setAllowedTsa(allowed);
        }

        /* =======================
           7️⃣ BUILD PLANNING SOLUTION
           ======================= */
        Timetable problem = new Timetable();
        problem.setScheduledClasses(nonElectives);
        problem.setTsaList(allTsa);

        // SLOT POOLS
        problem.setLecSlots(lecSlots);
        problem.setLabSlots(labSlots);

        // ROOM POOLS
        problem.setLecRooms(lecRooms);
        problem.setLabRooms(labRooms);
        problem.setClassrooms(allRooms);

        // EQUI TIMESLOTS
        List<EquiTimeSlot> equiSlots = equiTimeSlotRepository.findAll();
        problem.setEquiTimeSlotList(equiSlots);

        // 🔥 SLOT BLOCKS (ONLY NEW ADDITION)
        List<SlotBlock> slotBlocks =
                slotBlockBuilder.build(equiSlots);
        problem.setSlotBlockList(slotBlocks);

        /* 🔥 VERY IMPORTANT */
        nonElectives.forEach(sc -> sc.setTimetable(problem));

        /* =======================
           8️⃣ SOLVE
           ======================= */
        Solver<Timetable> solver =
                TimetableSolver
                        .solverFactory(secondsLimit)
                        .buildSolver();

        Timetable solution = solver.solve(problem);

        /* =======================
           9️⃣ SAVE RESULT
           ======================= */
        scheduledClassRepository.saveAllAndFlush(
                solution.getScheduledClasses()
        );
    }
}
