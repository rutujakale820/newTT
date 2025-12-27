package com.example.timetabler.dto;

import java.util.Set;

public record BlockedResources(
        Set<Long> blockedTimeSlots,
        Set<String> blockedTeacherSlots,
        Set<String> blockedClassroomSlots
) {}
