package com.example.timetabler.repositories;

import com.example.timetabler.entities.ElectiveDivision;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.example.timetabler.entities.Semester;

import java.util.Collection;
import java.util.List;

@Repository
public interface ElectiveDivisionRepository
        extends JpaRepository<ElectiveDivision, Long> {

    /* =====================================================
       CLEANUP
       ===================================================== */

    @Modifying
    @Transactional
    @Query("delete from ElectiveDivision")
    void deleteAllElectiveDivisions();

    @Modifying
    @Transactional
    @Query("""
        delete from ElectiveDivision ed
        where ed.semester.id = :semesterId
    """)
    void deleteBySemesterId(@Param("semesterId") Long semesterId);

    /* =====================================================
       BASIC FETCH
       ===================================================== */

    @Query("""
        select ed
        from ElectiveDivision ed
        where ed.semester.id = :semesterId
    """)
    List<ElectiveDivision> findBySemesterId(
            @Param("semesterId") Long semesterId
    );

    /* =====================================================
       HARD CONSTRAINTS (SLOT BASED)
       ===================================================== */

    // ❌ Teacher cannot teach two divisions at same slot
    @Query("""
        select count(ed) > 0
        from ElectiveDivision ed
        where ed.teacher.id = :teacherId
          and ed.timeSlot.id = :slotId
          and ed.semester.id = :semesterId
    """)
    boolean existsByTeacherAndTimeSlot(
            @Param("teacherId") Long teacherId,
            @Param("slotId") Long slotId,
            @Param("semesterId") Long semesterId
    );

    // ❌ Classroom cannot host two divisions at same slot
    @Query("""
        select count(ed) > 0
        from ElectiveDivision ed
        where ed.classroom.id = :classroomId
          and ed.timeSlot.id = :slotId
          and ed.semester.id = :semesterId
    """)
    boolean existsByClassroomAndTimeSlot(
            @Param("classroomId") Long classroomId,
            @Param("slotId") Long slotId,
            @Param("semesterId") Long semesterId
    );

    // ❌ Same slot already used in semester (LAB–LEC blocking)
    @Query("""
        select count(ed) > 0
        from ElectiveDivision ed
        where ed.timeSlot.id = :slotId
          and ed.semester.id = :semesterId
    """)
    boolean existsByTimeSlotId(
            @Param("slotId") Long slotId,
            @Param("semesterId") Long semesterId
    );

    // ❌ Prevent same parent elective using same slot twice
    @Query("""
        select count(ed) > 0
        from ElectiveDivision ed
        where ed.parentElective.id = :parentId
          and ed.timeSlot.id = :slotId
          and ed.semester.id = :semesterId
    """)
    boolean existsByParentAndSlot(
            @Param("parentId") Long parentId,
            @Param("slotId") Long slotId,
            @Param("semesterId") Long semesterId
    );

    @Query("""
        select
            ed.parentElective.id,
            ed.semester.id,
            ed.timeSlot.id
        from ElectiveDivision ed
        group by
            ed.parentElective.id,
            ed.semester.id,
            ed.timeSlot.id
    """)
    List<Object[]> findUniqueParentSemesterSlot();


    List<ElectiveDivision> findBySemesterAndElectiveDivCodeContaining(Semester semester, String code);

    // 🔥 NEW METHOD: Find divisions by semester that do NOT contain a specific code (for LEC)
    List<ElectiveDivision> findBySemesterAndElectiveDivCodeNotContaining(Semester semester, String code);

    boolean existsByTeacherIdAndTimeSlotIdIn(Long teacherId, Collection<Long> timeSlotIds);
boolean existsByClassroomIdAndTimeSlotId(Long classroomId, Long timeSlotId);


}
