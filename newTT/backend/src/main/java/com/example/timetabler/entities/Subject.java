package com.example.timetabler.entities;

import lombok.*;
import jakarta.persistence.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Subject {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String category;
    private String code;
    private String name;
    private Integer priority;

    @Column(name = "subject_type")
    private String subjectType;

    @Column(name = "weekly_lab_hours")
    private Integer weeklyLabHours;

    @Column(name = "weekly_lecture_hours")
    private Integer weeklyLectureHours;

    @Column(name = "weekly_tutorial_hours")
    private Integer weeklyTutorialHours;

    @Column(name = "elective")
    private Integer elective;   // 0 or 1

    @Column(name = "elective_type")
    private String electiveType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "semester_id")
    private Semester semester;

    /* ================= CONVENIENCE METHODS ================= */

    public boolean isElective() {
        return elective != null && elective == 1;
    }

    public int getLecHours() {
        return weeklyLectureHours != null ? weeklyLectureHours : 0;
    }

    public int getLabHours() {
        return weeklyLabHours != null ? weeklyLabHours : 0;
    }

    public int getTutHours() {
        return weeklyTutorialHours != null ? weeklyTutorialHours : 0;
    }
}
