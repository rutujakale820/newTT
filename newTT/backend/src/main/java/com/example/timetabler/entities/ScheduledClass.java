package com.example.timetabler.entities;

import com.example.timetabler.entities.enums.SessionType;
import jakarta.persistence.*;
import lombok.*;
import org.optaplanner.core.api.domain.entity.PlanningEntity;
import org.optaplanner.core.api.domain.entity.PlanningPin;
import org.optaplanner.core.api.domain.lookup.PlanningId;
import org.optaplanner.core.api.domain.valuerange.ValueRangeProvider;
import org.optaplanner.core.api.domain.variable.PlanningVariable;

import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@PlanningEntity
public class ScheduledClass {

    /* ================= ID ================= */

    @PlanningId
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    
    /* ================= META ================= */

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private SessionType sessionType; // LEC / LAB / TUT

    @ManyToOne
    private Batch batch;

    @ManyToOne
    private Division division;

    /* ================= CLASSROOM (🔥 MISSING PIECE FIXED) ================= */

    @ManyToOne
    @PlanningVariable(valueRangeProviderRefs = "roomRange")
    private Classroom classroom;

    @Transient
    private Timetable timetable;

    @ValueRangeProvider(id = "roomRange")
public List<Classroom> allowedClassrooms() {

    if (timetable == null) {
        return List.of();
    }

    // 🔥 LAB → only lab rooms
    if (sessionType == SessionType.LAB) {
        return timetable.getLabRooms() == null
                ? List.of()
                : timetable.getLabRooms();
    }

    // 🔥 LEC → only lecture rooms
    if (sessionType == SessionType.LEC) {
        return timetable.getLecRooms() == null
                ? List.of()
                : timetable.getLecRooms();
    }

    // 🔥 TUT → ANY classroom (LAB + LEC)
    // safest is to return all classrooms
    return timetable.getClassrooms() == null
            ? List.of()
            : timetable.getClassrooms();
}



    /* ================= SUBJECT ================= */

    @ManyToOne(optional = false)
    private Subject subject;

    /* ================= TEACHER (TSA) ================= */

    @ManyToOne
    @JoinColumn(name = "tsa_id")
    @PlanningVariable(valueRangeProviderRefs = "tsaRange")
    private TeacherSubjectAllocation teacherSubjectAllocation;

    /* ================= TSA RANGE (PER CLASS) ================= */

    @Transient
    private List<TeacherSubjectAllocation> allowedTsa;

    @ValueRangeProvider(id = "tsaRange")
    public List<TeacherSubjectAllocation> getAllowedTsa() {
        return allowedTsa;
    }

    /* ================= TIME SLOT ================= */

    @ManyToOne
    @PlanningVariable(valueRangeProviderRefs = "timeSlotRange")
    private TimeSlot timeSlot;

    @ValueRangeProvider(id = "timeSlotRange")
    public List<TimeSlot> allowedTimeSlots() {

        if (timetable == null) return List.of();

        if (sessionType == SessionType.LAB) {
            return timetable.getLabSlots();   // LAB → LAB slots
        } else {
            return timetable.getLecSlots();   // LEC/TUT → LEC slots
        }
    }

    /* ================= ACADEMIC ================= */

    @Column(nullable = false)
    private Integer electiveFlag; // 0 = normal, 1 = elective

    @ManyToOne(optional = false)
    private Semester semester;

    /* ================= PIN ================= */

    @PlanningPin
    private boolean pinned;

    /* ================= DERIVED TEACHER ================= */

    @Transient
    public Teacher getTeacher() {
        return teacherSubjectAllocation == null
                ? null
                : teacherSubjectAllocation.getTeacher();
    }
}
