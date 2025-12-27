package com.example.timetabler.optaplanner.facts;

import com.example.timetabler.entities.*;
import com.example.timetabler.repositories.ElectiveDivisionRepository;
import com.example.timetabler.repositories.TimeSlotRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.*;

/**
 * Builds virtual SlotBlock facts from elective_division table.
 * These blocks are used by OptaPlanner constraints to prevent
 * regular classes from overlapping electives (including equi slots).
 */
@Component
@RequiredArgsConstructor
public class SlotBlockBuilder {

    private final ElectiveDivisionRepository electiveDivisionRepo;
    private final TimeSlotRepository timeSlotRepo;

    /**
     * Build SlotBlocks from elective_division + equi_time_slot.
     */
    public List<SlotBlock> build(List<EquiTimeSlot> equiSlots) {

        List<SlotBlock> blocks = new ArrayList<>();

        // 🔥 Used to avoid duplicate SlotBlocks (performance + correctness)
        Set<String> seenKeys = new HashSet<>();

        for (ElectiveDivision ed : electiveDivisionRepo.findAll()) {

            Semester sem = ed.getSemester();
            TimeSlot baseSlot = ed.getTimeSlot();
            Teacher teacher = ed.getTeacher();
            Classroom classroom = ed.getClassroom();

            // 1️⃣ EXACT SLOT BLOCK
            addIfAbsent(
                    seenKeys,
                    blocks,
                    sem,
                    baseSlot,
                    teacher,
                    classroom
            );

            // 2️⃣ EQUI SLOT BLOCKS
            for (EquiTimeSlot eq : equiSlots) {
                TimeSlot other = getOtherSlot(eq, baseSlot);
                if (other != null) {
                    addIfAbsent(
                            seenKeys,
                            blocks,
                            sem,
                            other,
                            teacher,
                            classroom
                    );
                }
            }
        }

        return blocks;
    }

    /**
     * Add SlotBlock only if same combination not already added.
     */
    private void addIfAbsent(
            Set<String> seen,
            List<SlotBlock> blocks,
            Semester sem,
            TimeSlot slot,
            Teacher teacher,
            Classroom classroom) {

        if (slot == null) return;

        // Unique key: semester + slot + teacher + classroom
        String key =
                (sem != null ? sem.getId() : "ALL") + "|" +
                slot.getId() + "|" +
                (teacher != null ? teacher.getId() : "ANY") + "|" +
                (classroom != null ? classroom.getId() : "ANY");

        if (seen.add(key)) {
            blocks.add(new SlotBlock(
                    sem,
                    slot,
                    teacher,
                    classroom,
                    BlockType.ELECTIVE
            ));
        }
    }

    /**
     * Returns the equivalent slot (LAB ↔ LEC) if applicable.
     */
    private TimeSlot getOtherSlot(EquiTimeSlot eq, TimeSlot slot) {

        if (eq == null || slot == null) return null;

        if (eq.getLabSlot().equals(slot.getId())) {
            return timeSlotRepo.getReferenceById(eq.getLecSlot());
        }

        if (eq.getLecSlot().equals(slot.getId())) {
            return timeSlotRepo.getReferenceById(eq.getLabSlot());
        }

        return null;
    }
}
