package com.example.timetabler.controllers;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/dev")
@RequiredArgsConstructor
public class AdminLoginController {

    @PostMapping("/admin/login")
    public AdminLoginResponse login(@RequestBody AdminLoginRequest req) {

        // 🔐 Simple dummy authentication
        if (!"admin@gmail.com".equals(req.getEmail()) ||
            !"admin123".equals(req.getPassword())) {
            return new AdminLoginResponse("ERROR", "Invalid admin credentials");
        }

        return new AdminLoginResponse("OK", "Admin Login Successful");
    }

    @Getter
    @Setter
    static class AdminLoginRequest {
        private String email;
        private String password;
    }

    @Getter
    static class AdminLoginResponse {
        private String status;
        private String message;

        public AdminLoginResponse(String status, String message) {
            this.status = status;
            this.message = message;
        }
    }
}
