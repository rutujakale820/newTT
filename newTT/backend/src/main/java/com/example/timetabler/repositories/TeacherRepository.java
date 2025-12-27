package com.example.timetabler.repositories;

import com.example.timetabler.entities.Teacher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface TeacherRepository extends JpaRepository<Teacher, Long> {

    @Query("""
        select count(sc) = 0
        from ScheduledClass sc
        where sc.teacherSubjectAllocation.teacher.id = :teacherId
          and sc.timeSlot.id = :slotId
    """)
    boolean isTeacherFree(
            @Param("teacherId") Long teacherId,
            @Param("slotId") Long slotId
    );
}
