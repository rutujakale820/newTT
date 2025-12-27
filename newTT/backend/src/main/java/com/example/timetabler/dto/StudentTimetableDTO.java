package com.example.timetabler.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class StudentTimetableDTO {

    private Long scheduledClassId;   // <-- ADD THIS

    private Integer dayOfWeek;
    private String startTime;
    private String endTime;

    private String subjectName;
    private String teacherCode;
    private String roomNumber;

    private String sessionType;
    private String batchName;
}
