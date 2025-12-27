package com.example.timetabler.entities;

import java.util.Objects;

public class TeacherSubjectKey {

    private final Long teacherId;
    private final Long subjectId;

    public TeacherSubjectKey(Long teacherId, Long subjectId) {
        this.teacherId = teacherId;
        this.subjectId = subjectId;
    }

    public Long getTeacherId() {
        return teacherId;
    }

    public Long getSubjectId() {
        return subjectId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof TeacherSubjectKey)) return false;
        TeacherSubjectKey that = (TeacherSubjectKey) o;
        return Objects.equals(teacherId, that.teacherId)
            && Objects.equals(subjectId, that.subjectId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(teacherId, subjectId);
    }
}
