package com.example.timetabler.entities;

import jakarta.persistence.*;
import java.util.Objects;

@Entity
public class TeacherSubjectAllocation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    private Teacher teacher;

    @ManyToOne(optional = false)
    private Subject subject;

    public TeacherSubjectAllocation() {}

    public TeacherSubjectAllocation(Teacher teacher, Subject subject) {
        this.teacher = teacher;
        this.subject = subject;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Teacher getTeacher() { return teacher; }
    public void setTeacher(Teacher teacher) { this.teacher = teacher; }

    public Subject getSubject() { return subject; }
    public void setSubject(Subject subject) { this.subject = subject; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof TeacherSubjectAllocation)) return false;
        TeacherSubjectAllocation that = (TeacherSubjectAllocation) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(id);
    }
}
