package com.example.timetabler.controllers;

import com.example.timetabler.entities.Division;
import com.example.timetabler.repositories.DivisionRepository;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/dev")
@RequiredArgsConstructor
public class DevLoginController {

    private final DivisionRepository divisionRepository;

    @PostMapping("/login")
    public LoginResponse login(@RequestBody LoginRequest req) {

        // 🔐 1. Dummy authentication
        if (!"student@gmail.com".equals(req.getEmail())
                || !"student123".equals(req.getPassword())) {
            return new LoginResponse("ERROR", "Invalid credentials");
        }

        // 🚫 2. Semester 1 & 2 never allowed
        if (req.getSemesterId() == null || req.getSemesterId() < 3) {
            return new LoginResponse("ERROR", "Semester not allowed");
        }

        // 🎯 3. Validate division for that semester
        Division division =
                divisionRepository
                        .findBySemesterIdAndName(
                                req.getSemesterId(),
                                req.getDivisionName()
                        )
                        .orElse(null);

        if (division == null) {
            return new LoginResponse("ERROR", "Invalid division");
        }

        // ✅ 4. Success
        return new LoginResponse(
                "OK",
                "Login successful",
                division.getId(),
                division.getSemester().getId(),
                division.getName()
        );
    }

    /* ================= DTOs ================= */

    @Getter
    @Setter
    static class LoginRequest {
        private String email;
        private String password;
        private Integer semesterId;
        private String divisionName;
    }

    @Getter
    static class LoginResponse {
        private String status;
        private String message;
        private Long divisionId;
        private Long semesterId;
        private String divisionName;

        // ✅ SUCCESS constructor
        public LoginResponse(String status, String message,
                             Long divisionId, Long semesterId, String divisionName) {
            this.status = status;
            this.message = message;
            this.divisionId = divisionId;
            this.semesterId = semesterId;
            this.divisionName = divisionName;
        }

        // ✅ ERROR constructor (🔥 THIS WAS MISSING)
        public LoginResponse(String status, String message) {
            this.status = status;
            this.message = message;
        }
    }
}
