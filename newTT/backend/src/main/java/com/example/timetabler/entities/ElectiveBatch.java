package com.example.timetabler.entities;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "elective_batch")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ElectiveBatch {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Integer batchIndex;
    private Integer size;

    @ManyToOne
    @JoinColumn(name = "elective_division_id")
    private ElectiveDivision electiveDivision;

    @ManyToOne
    @JoinColumn(name = "classroom_id")
    private Classroom classroom;

    @ManyToOne
    @JoinColumn(name = "time_slot_id")
    private TimeSlot timeSlot;
}
