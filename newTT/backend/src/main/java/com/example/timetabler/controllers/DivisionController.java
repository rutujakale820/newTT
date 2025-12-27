package com.example.timetabler.controllers;

import com.example.timetabler.entities.Division;
import com.example.timetabler.entities.Semester;
import com.example.timetabler.repositories.DivisionRepository;
import com.example.timetabler.repositories.ScheduledClassRepository;
import com.example.timetabler.repositories.SemesterRepository;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/dev/divisions")
@RequiredArgsConstructor
public class DivisionController {

    private final DivisionRepository divisionRepository;
    private final ScheduledClassRepository scheduledClassRepository;
    private final SemesterRepository semesterRepository;

    @GetMapping
    public List<Division> getDivisionsForGeneratedTimetable() {

        // 🔥 Only sem >= 3 will ever come
        List<Long> activeSemesterIds =
                scheduledClassRepository.findActiveSemesterIdsExcludingFY();

        if (activeSemesterIds.isEmpty()) {
            return List.of();
        }

        return divisionRepository.findBySemesterIds(activeSemesterIds);
    }
    @GetMapping("/semesters")
public List<Semester> getSemesters() {
    return semesterRepository.findAll();
}
@GetMapping("/divisions/{semesterId}")
public List<SimpleDivisionDTO> getDivisions(@PathVariable Long semesterId) {
    return divisionRepository.findBySemesterId(semesterId)
            .stream()
            .map(d -> new SimpleDivisionDTO(d.getId(), d.getName()))
            .toList();
}

record SimpleDivisionDTO(Long id, String name) {}



}
