package com.example.timetabler.optaplanner.facts;

/**
 * Describes why a slot is blocked.
 * This is a virtual concept, not stored in DB.
 */
public enum BlockType {

    /**
     * Slot blocked because of elective execution
     */
    ELECTIVE,

    /**
     * Slot blocked globally (maintenance, events, exams, etc.)
     */
    GLOBAL,

    /**
     * Slot blocked temporarily (future extension)
     */
    MAINTENANCE
}
