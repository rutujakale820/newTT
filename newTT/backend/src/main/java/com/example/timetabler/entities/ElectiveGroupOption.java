package com.example.timetabler.entities;

import jakarta.persistence.*;
import lombok.*;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name = "elective_group_option")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
public class ElectiveGroupOption {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Integer maxIntake;
    private Integer minIntake;

    private String optionCode;
    private String optionName;

    @Column(name = "short_name", length = 20)
    private String shortName;

    /** ★ This field was missing → Hibernate crashed */
     @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "group_id")
    private ElectiveGroup electiveGroup;
}
