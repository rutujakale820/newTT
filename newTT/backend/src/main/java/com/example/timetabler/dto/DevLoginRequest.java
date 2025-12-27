package com.example.timetabler.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DevLoginRequest {
    private String email;
    private String password;
    private Integer semesterId;
    private String divisionName;
}
