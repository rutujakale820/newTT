package com.example.timetabler.optaplanner.facts;

import com.example.timetabler.entities.Classroom;
import com.example.timetabler.entities.Semester;
import com.example.timetabler.entities.Teacher;
import com.example.timetabler.entities.TimeSlot;
import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * Virtual solver fact.
 * Represents blocked availability for a slot.
 */
@Getter
@AllArgsConstructor
public class SlotBlock {

    /**
     * Semester for which the block applies.
     * NULL = applies to all semesters.
     */
    private Semester semester;

    /**
     * Blocked slot (or equi slot).
     */
    private TimeSlot timeSlot;

    /**
     * Blocked teacher (nullable).
     */
    private Teacher teacher;

    /**
     * Blocked classroom (nullable).
     */
    private Classroom classroom;

    /**
     * Reason (informational).
     */
    private BlockType blockType;
}
