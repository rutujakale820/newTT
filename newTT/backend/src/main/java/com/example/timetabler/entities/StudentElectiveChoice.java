package com.example.timetabler.entities;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "student_elective_choice")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class StudentElectiveChoice {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // chosen_option_id -> maps to elective_group_option.id (per your DB)
    @ManyToOne
    @JoinColumn(name = "chosen_option_id")
    private ElectiveGroupOption chosenOption;

    // parent_elective_id -> subject.id (parent elective)
    @ManyToOne
    @JoinColumn(name = "parent_elective_id")
    private Subject parentElective;

    private Integer count;
}
