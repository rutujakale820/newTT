package com.example.timetabler.util;

import java.time.LocalTime;

/**
 * Immutable value object for real-time overlap checks.
 */
public class TimeWindow {

    private final int dayOfWeek;   // 1=Mon ... 7=Sun
    private final LocalTime start;
    private final LocalTime end;

    public TimeWindow(int dayOfWeek, LocalTime start, LocalTime end) {
        this.dayOfWeek = dayOfWeek;
        this.start = start;
        this.end = end;
    }

    public boolean overlaps(TimeWindow other) {
        return this.dayOfWeek == other.dayOfWeek
                && this.start.isBefore(other.end)
                && other.start.isBefore(this.end);
    }

    public int getDayOfWeek() {
        return dayOfWeek;
    }

    public LocalTime getStart() {
        return start;
    }

    public LocalTime getEnd() {
        return end;
    }
}
