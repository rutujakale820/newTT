package com.example.timetabler.dto;

import lombok.Data;
import com.example.timetabler.entities.enums.SessionType;

@Data
public class AddRequest {

    private Long divisionId;
    private Long subjectId;
    private Long teacherSubjectAllocationId;
    private Long roomId;
    private Long timeSlotId;

    private SessionType sessionType;

}
