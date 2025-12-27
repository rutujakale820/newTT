package com.example.timetabler.entities;

import lombok.*;
import org.optaplanner.core.api.domain.solution.*;
import org.optaplanner.core.api.domain.valuerange.ValueRangeProvider;
import org.optaplanner.core.api.score.buildin.hardsoft.HardSoftScore;

import com.example.timetabler.optaplanner.facts.SlotBlock;

import java.util.List;

@PlanningSolution
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Timetable {

    /* ================= VALUE RANGES ================= */

    @ProblemFactCollectionProperty
    private List<SlotBlock> slotBlockList;
    
    private List<Classroom> classrooms;

    /* TSA is NOT a value range here (entity-level range used) */
    private List<TeacherSubjectAllocation> tsaList;


    private List<Classroom> lecRooms;
    private List<Classroom> labRooms;
    
    /* ================= SLOT POOLS ================= */
    private List<TimeSlot> lecSlots;
    private List<TimeSlot> labSlots;

    /* ================= PROBLEM FACTS ================= */

    @ProblemFactCollectionProperty   // 🔥 THIS WAS MISSING
    private List<EquiTimeSlot> equiTimeSlotList;

    /* ================= PLANNING ENTITIES ================= */

    @PlanningEntityCollectionProperty
    private List<ScheduledClass> scheduledClasses;

    /* ================= SCORE ================= */

    @PlanningScore
    private HardSoftScore score;
}
