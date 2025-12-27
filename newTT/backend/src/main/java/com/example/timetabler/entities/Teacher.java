package com.example.timetabler.entities;

import jakarta.persistence.*;
import lombok.*;
import org.optaplanner.core.api.domain.lookup.PlanningId;

import java.util.List;

@Entity
@Table(name = "teacher")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Teacher {

    /* ================= ID ================= */

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @PlanningId
    private Long id;

    /* ================= AUTH / IDENTITY ================= */

    @Column(nullable = false, unique = true)
    private String email;

    @Column(name = "employee_id", nullable = false, unique = true)
    private String employeeId;

    /* ================= DISPLAY FIELDS ================= */

    // Full name (as per DB)
    @Column(nullable = false)
    private String name;

    // Short code like RS, PM, SNO (USED IN UI)
    @Column(name = "teacher_code", nullable = false, unique = true)
    private String teacherCode;

    

    /* ================= DEPARTMENT ================= */

    @ManyToOne
    @JoinColumn(name = "department_id")
    private Department department;

    /* ================= CONSTRAINTS ================= */

    @Column(name = "max_weekly_load")
    private Integer maxWeeklyLoad;

    @Column(name = "max_hours_per_day")
    private Integer maxHoursPerDay;

    @Column(name = "max_continuous_hours")
    private Integer maxContinuousHours;

    /* ================= SUBJECTS (TSA) ================= */

    /**
     * This mapping reflects the SAME teacher_subject_allocation table
     * but is OPTIONAL for display / admin use.
     * OptaPlanner should still rely on TeacherSubjectAllocation entity.
     */
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "teacher_subject_allocation",
        joinColumns = @JoinColumn(name = "teacher_id"),
        inverseJoinColumns = @JoinColumn(name = "subject_id")
    )
    private List<Subject> subjects;
}
