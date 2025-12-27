package com.example.timetabler.controllers;

import com.example.timetabler.dto.AddRequest;
import com.example.timetabler.dto.StudentTimetableDTO;
import com.example.timetabler.entities.*;
import com.example.timetabler.repositories.*;
import com.example.timetabler.services.DevStudentTimetableService;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalTime;
import java.util.List;

@RestController
@RequestMapping("/api/dev")
@CrossOrigin(origins = "http://localhost:5173")
public class AdminController {

    private final ScheduledClassRepository scheduledClassRepository;
    private final TeacherRepository teacherRepository;
    private final ClassroomRepository classroomRepository;
    private final DivisionRepository divisionRepository;
    private final SubjectRepository subjectRepository;
    private final DevStudentTimetableService devStudentTimetableService;
    private final TimeSlotRepository timeSlotRepository;
    private final TeacherSubjectAllocationRepository teacherSubjectAllocationRepository;


    public AdminController(
            ScheduledClassRepository scheduledClassRepository,
            TeacherRepository teacherRepository,
            ClassroomRepository classroomRepository,
            DivisionRepository divisionRepository,
            SubjectRepository subjectRepository,
            DevStudentTimetableService devStudentTimetableService,
            TimeSlotRepository timeSlotRepository,
            TeacherSubjectAllocationRepository teacherSubjectAllocationRepository
    ) {
        this.scheduledClassRepository = scheduledClassRepository;
        this.teacherRepository = teacherRepository;
        this.classroomRepository = classroomRepository;
        this.divisionRepository = divisionRepository;
        this.subjectRepository = subjectRepository;
        this.devStudentTimetableService = devStudentTimetableService;
        this.timeSlotRepository=timeSlotRepository;
        this.teacherSubjectAllocationRepository=teacherSubjectAllocationRepository;
    }

    @GetMapping("/timetable")
public List<StudentTimetableDTO> getAdminDivisionTimetable(@RequestParam Long divisionId) {
    return devStudentTimetableService.getTimetableByDivision(divisionId);

}
@PostMapping("/timetable/add")
public ResponseEntity<?> addScheduledClass(@RequestBody AddRequest req) {

    Division division = divisionRepository.findById(req.getDivisionId())
            .orElseThrow(() -> new RuntimeException("Division not found"));

    Subject subject = subjectRepository.findById(req.getSubjectId())
            .orElseThrow(() -> new RuntimeException("Subject not found"));

    Classroom room = classroomRepository.findById(req.getRoomId())
            .orElseThrow(() -> new RuntimeException("Room not found"));

    TeacherSubjectAllocation tsa =
            teacherSubjectAllocationRepository.findById(req.getTeacherSubjectAllocationId())
                    .orElseThrow(() -> new RuntimeException("TSA not found"));

    TimeSlot slot =
            timeSlotRepository.findById(req.getTimeSlotId())
                    .orElseThrow(() -> new RuntimeException("Slot not found"));

    /* ================= VALIDATIONS ================= */

    // 1️⃣ Room Clash
    boolean roomClash = scheduledClassRepository
            .existsByTimeSlotAndClassroom(slot, room);

    if (roomClash)
        return ResponseEntity.badRequest().body("❌ Room already booked at this time");

   boolean teacherClash =
        scheduledClassRepository.existsByTimeSlotAndTeacherSubjectAllocation_Teacher(
                slot,
                tsa.getTeacher()
        );


    if (teacherClash)
        return ResponseEntity.badRequest().body("❌ Teacher is already assigned at this time");

    // 3️⃣ Division Clash (cannot have 2 classes at same time)
    boolean divisionClash =
            scheduledClassRepository.existsByTimeSlotAndDivision(
                    slot,
                    division
            );

    if (divisionClash)
        return ResponseEntity.badRequest().body("❌ Division already has a class at this time");


    /* ================= SAVE ================= */
    ScheduledClass sc = new ScheduledClass();

    sc.setDivision(division);
    sc.setSubject(subject);
    sc.setTeacherSubjectAllocation(tsa);
    sc.setClassroom(room);
    sc.setSessionType(req.getSessionType());
    sc.setTimeSlot(slot);
    sc.setElectiveFlag(0);
    sc.setPinned(false);
    sc.setSemester(division.getSemester());

    scheduledClassRepository.save(sc);

    return ResponseEntity.ok("✅ Class Added Successfully");
}




@DeleteMapping("/timetable/delete/{id}")
public ResponseEntity<?> deleteClass(@PathVariable Long id) {
    if (!scheduledClassRepository.existsById(id)) {
        return ResponseEntity.badRequest().body("Class not found");
    }

    scheduledClassRepository.deleteById(id);
    return ResponseEntity.ok("Deleted");
}
/* ===================== ADMIN DROPDOWN APIs ===================== */

@GetMapping("/admin/subjects/{divisionId}")
public List<SimpleSubjectDTO> getSubjects(@PathVariable Long divisionId) {

    Division d = divisionRepository.findById(divisionId)
            .orElseThrow(() -> new RuntimeException("Division not found"));

    return subjectRepository.findBySemesterId(d.getSemester().getId())
            .stream()
            .map(s -> new SimpleSubjectDTO(s.getId(), s.getName()))
            .toList();
}

@GetMapping("/admin/teachers/{divisionId}")
public List<SimpleTeacherDTO> getTeachers(@PathVariable Long divisionId) {

    Division d = divisionRepository.findById(divisionId)
            .orElseThrow(() -> new RuntimeException("Division not found"));

    Long semId = d.getSemester().getId();

    return teacherSubjectAllocationRepository.findAll()
            .stream()
            .filter(tsa -> tsa.getSubject().getSemester().getId().equals(semId))
            .map(tsa -> new SimpleTeacherDTO(
                    tsa.getId(),
                    tsa.getTeacher().getTeacherCode()
  // << teacherCode field
            ))
            .toList();
}

@GetMapping("/admin/rooms/{divisionId}")
public List<SimpleRoomDTO> getRooms(@PathVariable Long divisionId) {

    // currently returning ALL rooms (safe)
    // if later you want filtering by LAB/LEC we can do it

    return classroomRepository.findAll()
            .stream()
            .map(r -> new SimpleRoomDTO(r.getId(), r.getRoomNumber()))
            .toList();
}

@GetMapping("/admin/timeslots/{divisionId}")
public List<SimpleSlotDTO> getSlots(@PathVariable Long divisionId) {

    // returning all slots (works for now)
    // if needed later we can split lec/lab/etc

    return timeSlotRepository.findAll()
            .stream()
            .map(ts -> new SimpleSlotDTO(
                    ts.getId(),
                    ts.getDayOfWeek(),
                    ts.getStartTime().toString(),
                    ts.getEndTime().toString()
            ))
            .toList();
}

@Data
@AllArgsConstructor
static class SimpleSubjectDTO {
    private Long id;
    private String name;
}

@Data
@AllArgsConstructor
static class SimpleTeacherDTO {
    private Long id;
    private String teacherCode;
}

@Data
@AllArgsConstructor
static class SimpleRoomDTO {
    private Long id;
    private String roomNumber;
}

@Data
@AllArgsConstructor
static class SimpleSlotDTO {
    private Long id;
    private Integer dayOfWeek;
    private String startTime;
    private String endTime;
}



}