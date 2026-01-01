package com.example.timetabler.controllers;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/dev/teacher")
public class TeacherLoginController {


    @GetMapping("/ping")
public String ping() {
    return "Teacher controller loaded";
}

    @PostMapping("/login")
    public TeacherLoginResponse login(@RequestBody TeacherLoginRequest req) {

        // 🔐 Dummy authentication (JUST ONE TEACHER)
        if (!"teacher@gmail.com".equals(req.getEmail())
                || !"teacher123".equals(req.getPassword())) {

            return new TeacherLoginResponse("ERROR", "Invalid credentials");
        }

        // ✅ Dummy success response
        return new TeacherLoginResponse(
                "OK",
                "Login successful",
                "TEACHER"   // role
        );
    }

    /* ================= DTOs ================= */

    @Getter
    @Setter
    static class TeacherLoginRequest {
        private String email;
        private String password;
    }

    @Getter
    static class TeacherLoginResponse {
        private String status;
        private String message;
        private String role;

        // SUCCESS
        public TeacherLoginResponse(String status, String message, String role) {
            this.status = status;
            this.message = message;
            this.role = role;
        }

        // ERROR
        public TeacherLoginResponse(String status, String message) {
            this.status = status;
            this.message = message;
        }
    }
}
