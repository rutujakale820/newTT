package com.example.timetabler.entities;

import java.util.List;

import org.optaplanner.core.api.domain.entity.PlanningEntity;
import org.optaplanner.core.api.domain.valuerange.ValueRangeProvider;
import org.optaplanner.core.api.domain.variable.PlanningVariable;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "elective_division")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ElectiveDivision {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "student_count")
    private Integer studentCount;

    @ManyToOne
    @JoinColumn(name = "classroom_id")
    private Classroom classroom;

    @ManyToOne
    @JoinColumn(name = "parent_elective_id")
    private Subject parentElective;

    @ManyToOne
    @JoinColumn(name = "teacher_id")
    private Teacher teacher;

    @ManyToOne
    @JoinColumn(name = "time_slot_id")
    private TimeSlot timeSlot;

    // 🔥 THIS MUST MATCH DB COLUMN NAME
    @ManyToOne
    @JoinColumn(name = "elective_group_option_id")
    private ElectiveGroupOption electiveOption;

    @ManyToOne
    @JoinColumn(name = "semester_id")
    private Semester semester;

    @Column(name = "elective_div_code")
    private String electiveDivCode;
}
