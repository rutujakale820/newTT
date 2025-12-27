package com.example.timetabler.repositories;

import com.example.timetabler.entities.Teacher;
import com.example.timetabler.entities.TeacherSubjectAllocation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TeacherSubjectAllocationRepository
        extends JpaRepository<TeacherSubjectAllocation, Long> {

    /* =========================================================
       🔥 CORE METHOD (USED BY GENERATOR + SOLVER)
       ========================================================= */

    /**
     * Returns ALL TeacherSubjectAllocation rows for a subject.
     * This is the ONLY method you should use for TSA-based planning.
     */
    List<TeacherSubjectAllocation> findBySubject_Id(Long subjectId);


    /* =========================================================
       OPTIONAL / SUPPORT METHODS (SAFE TO KEEP)
       ========================================================= */

    /**
     * Validity check (rarely needed now, value-range already enforces it)
     */
    boolean existsByTeacherIdAndSubjectId(Long teacherId, Long subjectId);

    /**
     * Same validity check using JPQL (legacy / debugging)
     */
    @Query("""
        SELECT COUNT(tsa) > 0
        FROM TeacherSubjectAllocation tsa
        WHERE tsa.teacher.id = :teacherId
          AND tsa.subject.id = :subjectId
    """)
    boolean existsTeacherForSubject(
            @Param("teacherId") Long teacherId,
            @Param("subjectId") Long subjectId
    );

    /**
     * If you ever need ONLY teachers (NOT TSA) for UI / reports
     */
    @Query("""
        SELECT tsa.teacher
        FROM TeacherSubjectAllocation tsa
        WHERE tsa.subject.id = :subjectId
    """)
    List<Teacher> findTeachersBySubjectId(
            @Param("subjectId") Long subjectId
    );
}
