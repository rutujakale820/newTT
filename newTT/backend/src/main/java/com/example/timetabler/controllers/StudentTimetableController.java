package com.example.timetabler.controllers;

import com.example.timetabler.dto.StudentTimetableDTO;
import com.example.timetabler.services.DevStudentTimetableService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/dev/student")
@RequiredArgsConstructor
public class StudentTimetableController {

    private final DevStudentTimetableService service;

    @GetMapping("/timetable")
    public List<StudentTimetableDTO> getStudentTimetable(
            @RequestParam Long divisionId) {

        return service.getTimetableByDivision(divisionId);
    }
}
