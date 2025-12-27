package com.example.timetabler.controllers;

import com.example.timetabler.services.ElectiveSchedulerService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/electives")
@RequiredArgsConstructor
public class ElectiveController {

    private final ElectiveSchedulerService electiveSchedulerService;

    @PostMapping("/assign/even")
    public ResponseEntity<String> assignEven() {
        electiveSchedulerService.generateElectives("EVEN");
        return ResponseEntity.ok("Electives generated for EVEN semesters");
    }

    @PostMapping("/assign/odd")
    public ResponseEntity<String> assignOdd() {
        electiveSchedulerService.generateElectives("ODD");
        return ResponseEntity.ok("Electives generated for ODD semesters");
    }
}
