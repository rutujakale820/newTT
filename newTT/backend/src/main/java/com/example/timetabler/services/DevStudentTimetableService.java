package com.example.timetabler.services;

import com.example.timetabler.dto.StudentTimetableDTO;
import com.example.timetabler.entities.*;
import com.example.timetabler.repositories.ScheduledClassRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DevStudentTimetableService {

    private final ScheduledClassRepository repository;

    public List<StudentTimetableDTO> getTimetableByDivision(Long divisionId) {

        return repository.findForStudentDivision(divisionId)
                .stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }

    private StudentTimetableDTO toDto(ScheduledClass sc) {

        TimeSlot slot = sc.getTimeSlot();
        Teacher teacher = sc.getTeacher();
        Classroom classroom = sc.getClassroom();
        Batch batch = sc.getBatch();

        StudentTimetableDTO dto = new StudentTimetableDTO();

        // DAY + TIME
        dto.setScheduledClassId(sc.getId());

        dto.setDayOfWeek(slot.getDayOfWeek());
        dto.setStartTime(slot.getStartTime().toString());
        dto.setEndTime(slot.getEndTime().toString());

        // SUBJECT
        dto.setSubjectName(sc.getSubject().getName());

        // TEACHER (NO CODE FIELD → USE NAME)
        dto.setTeacherCode(
                teacher != null ? teacher.getName() : "-"
        );

        // CLASSROOM
        dto.setRoomNumber(
                classroom != null ? classroom.getRoomNumber() : "-"
        );

        // SESSION TYPE
        dto.setSessionType(sc.getSessionType().name());

        // 🔥🔥🔥 FINAL FIX — USE batchName
        dto.setBatchName(
                batch != null ? batch.getBatchName() : null
        );

        return dto;
    }
}
