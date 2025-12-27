package com.example.timetabler.controllers;

import com.example.timetabler.services.GenerateInitialClassesService;
import com.example.timetabler.services.SchedulerService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/scheduler")
@RequiredArgsConstructor

public class SchedulerController {

    private final GenerateInitialClassesService generateInitialClassesService;
    private final SchedulerService schedulerService;

    // 🔹 STEP 1: INITIAL GENERATION
    @PostMapping("/generate/{mode}")
    public String generate(@PathVariable String mode) {

        System.out.println("🔥 GENERATE API HIT 🔥 mode=" + mode);
        generateInitialClassesService.generateInitialClasses(mode);

        return "Initial classes generated for mode = " + mode;
    }

    // 🔹 STEP 2: SOLVE
    @PostMapping("/solve/{mode}")
    public String solve(@PathVariable String mode) {

        schedulerService.solve(mode, 1200); // 3 minutes

        return "Solver finished for mode = " + mode;
    }
    
}
