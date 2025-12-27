package com.example.timetabler.util;

import com.example.timetabler.entities.TimeSlot;

public class TimeOverlapUtil {

    public static boolean overlaps(TimeSlot a, TimeSlot b) {
        return a.getDayOfWeek().equals(b.getDayOfWeek())
            && a.getStartTime().isBefore(b.getEndTime())
            && b.getStartTime().isBefore(a.getEndTime());
    }
}
