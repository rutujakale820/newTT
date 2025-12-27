package com.example.timetabler.entities;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "elective_option")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ElectiveOption {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // reference to the elective_group_option row chosen by students
    @ManyToOne
    @JoinColumn(name = "group_option_id")
    private ElectiveGroupOption groupOption;

    // actual subject that will be taught (maps to subject table)
    @ManyToOne
    @JoinColumn(name = "option_subject_id")
    private Subject optionSubject;

    // teacher preferred for this option (one row per teacher — you will have multiple rows per groupOption)
    @ManyToOne
    @JoinColumn(name = "preferred_teacher_id")
    private Teacher preferredTeacher;
}
