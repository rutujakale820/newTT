package com.example.timetabler.repositories;

import com.example.timetabler.entities.Classroom;
import com.example.timetabler.entities.Division;
import com.example.timetabler.entities.ScheduledClass;
import com.example.timetabler.entities.Semester;
import com.example.timetabler.entities.Teacher;
import com.example.timetabler.entities.TimeSlot;
import com.example.timetabler.entities.enums.SessionType;

import jakarta.transaction.Transactional;

import java.time.LocalTime;
import java.util.List;

import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ScheduledClassRepository
        extends JpaRepository<ScheduledClass, Long> {

    /* ================= ELECTIVE FREEZE ================= */

    @Modifying
    @Transactional
    @Query("""
        UPDATE ScheduledClass sc
        SET sc.pinned = true
        WHERE sc.electiveFlag = 1
    """)
    void freezeElectives();

    @Modifying
    @Transactional
    @Query("""
        UPDATE ScheduledClass sc
        SET sc.pinned = false
        WHERE sc.electiveFlag = 1
    """)
    void unfreezeElectives();

    @Modifying
    @Transactional
    @Query("""
        UPDATE ScheduledClass sc
        SET sc.teacherSubjectAllocation = NULL,
            sc.classroom = NULL
        WHERE sc.electiveFlag = 1
    """)
    void resetElectiveTeacherAndRoom();

    /* ================= BASIC CHECKS ================= */

    boolean existsByTimeSlotIsNull();

    long countByTimeSlotIsNull();

    /* ================= CLASH CHECKS ================= */

    boolean existsByClassroomIdAndTimeSlotId(
            Long classroomId,
            Long timeSlotId
    );

    boolean existsByBatchIdAndTimeSlotId(
            Long batchId,
            Long timeSlotId
    );

    boolean existsByDivisionIdAndTimeSlotId(
            Long divisionId,
            Long timeSlotId
    );

    boolean existsByTeacherSubjectAllocation_Teacher_IdAndTimeSlot_Id(
            Long teacherId,
            Long timeSlotId
    );

    /* ================= ELECTIVES ================= */

    @Query("""
        SELECT sc
        FROM ScheduledClass sc
        WHERE sc.electiveFlag = 1
          AND sc.semester.id = :semesterId
    """)
    List<ScheduledClass> findElectiveParentsBySemesterId(
            @Param("semesterId") Long semesterId
    );

    /* ================= PIN / UNPIN ================= */

    @Modifying
    @Transactional
    @Query("""
        UPDATE ScheduledClass sc
        SET sc.pinned = true
    """)
    void pinAll();

    @Modifying
    @Transactional
    @Query("""
        UPDATE ScheduledClass sc
        SET sc.timeSlot = NULL
        WHERE sc.timeSlot.lunch = true
           OR sc.timeSlot.shortBreak = true
    """)
    void nullifyBreakAssignments();

    @Modifying
    @Transactional
    @Query("""
        UPDATE ScheduledClass sc
        SET sc.pinned = false
        WHERE sc.sessionType = 'LAB'
    """)
    void unpinAllLabs();

    /* ================= ELECTIVE SAFETY ================= */

    @Query("""
        SELECT sc.timeSlot.id
        FROM ScheduledClass sc
        WHERE sc.semester.id = :semesterId
          AND sc.electiveFlag = 1
    """)
    List<Long> findElectiveSlotIdsBySemester(
            @Param("semesterId") Long semesterId
    );

    List<ScheduledClass> findBySemesterIdAndElectiveFlag(
            Long semesterId,
            int electiveFlag
    );

    @Query("""
        SELECT DISTINCT sc.timeSlot.id
        FROM ScheduledClass sc
        WHERE sc.electiveFlag = 1
          AND sc.semester.id = :semesterId
    """)
    List<Long> findBlockedSlotIdsForSemester(
            @Param("semesterId") Long semesterId
    );

    /* ================= OVERLAP CHECKS ================= */

    @Query("""
        SELECT COUNT(sc) > 0
        FROM ScheduledClass sc
        WHERE sc.semester.id = :semesterId
          AND sc.division.id = :divisionId
          AND sc.timeSlot.dayOfWeek = :day
          AND sc.timeSlot.startTime < :end
          AND sc.timeSlot.endTime   > :start
    """)
    boolean existsDivisionOverlap(
            Long semesterId,
            Long divisionId,
            String day,
            LocalTime start,
            LocalTime end
    );

    @Query("""
        SELECT COUNT(sc) > 0
        FROM ScheduledClass sc
        WHERE sc.semester.id = :semesterId
          AND sc.batch.id = :batchId
          AND sc.timeSlot.dayOfWeek = :day
          AND sc.timeSlot.startTime < :end
          AND sc.timeSlot.endTime   > :start
    """)
    boolean existsBatchOverlap(
            Long semesterId,
            Long batchId,
            String day,
            LocalTime start,
            LocalTime end
    );

    /* ================= TEACHER OVERLAP (TSA) ================= */

    @Query("""
        SELECT COUNT(sc) > 0
        FROM ScheduledClass sc
        WHERE sc.teacherSubjectAllocation.teacher.id = :teacherId
          AND sc.timeSlot.dayOfWeek = :day
          AND NOT (
              sc.timeSlot.endTime <= :start
              OR sc.timeSlot.startTime >= :end
          )
    """)
    boolean existsTeacherOverlap(
            @Param("teacherId") Long teacherId,
            @Param("day") String day,
            @Param("start") LocalTime start,
            @Param("end") LocalTime end
    );

    /* ================= TEMPLATE FETCH ================= */

    @Query("""
        SELECT sc
        FROM ScheduledClass sc
        WHERE sc.semester IN :semesters
          AND sc.pinned = false
          AND sc.teacherSubjectAllocation IS NULL
          AND sc.classroom IS NULL
          AND sc.timeSlot IS NULL
    """)
    List<ScheduledClass> findTemplatesBySemesterIn(
            @Param("semesters") List<Semester> semesters
    );

    /* ================= DELETE ================= */

    @Modifying
    @Transactional
    @Query("""
        DELETE FROM ScheduledClass sc
        WHERE sc.pinned = false
    """)
    void deleteUnpinned();

    /* ================= MODE ================= */

    @Query("""
        SELECT sc
        FROM ScheduledClass sc
        WHERE sc.semester.number % 2 =
              CASE WHEN :mode = 'EVEN' THEN 0 ELSE 1 END
    """)
    List<ScheduledClass> findBySemesterMode(
            @Param("mode") String mode
    );


        @Query("""
        SELECT DISTINCT sc.semester.id
        FROM ScheduledClass sc
    """)
    List<Long> findActiveSemesterIds();


    @Query("""
        SELECT DISTINCT sc.semester.id
        FROM ScheduledClass sc
        WHERE sc.semester.id >= 3
    """)
    List<Long> findActiveSemesterIdsExcludingFY();


    @Query("""
        SELECT sc
        FROM ScheduledClass sc
        JOIN FETCH sc.timeSlot ts
        JOIN FETCH sc.subject sub
        LEFT JOIN FETCH sc.batch b
        LEFT JOIN FETCH sc.classroom c
        LEFT JOIN FETCH sc.teacherSubjectAllocation tsa
        LEFT JOIN FETCH tsa.teacher t
        WHERE sc.division.id = :divisionId
        ORDER BY ts.dayOfWeek, ts.startTime
    """)
    List<ScheduledClass> findForStudentDivision(
            @Param("divisionId") Long divisionId
    );


    @Query("""
    select distinct sc.timeSlot.id
    from ScheduledClass sc
    where sc.semester.id = :semId
      and sc.timeSlot is not null
    order by sc.timeSlot.id
""")
List<Long> findUsedSlotIdsBySemester(@Param("semId") Long semId);


@Query("""
    select distinct sc.timeSlot.id
    from ScheduledClass sc
    where sc.semester.id = :semId
      and sc.timeSlot is not null
    order by sc.timeSlot.id
""")
List<Long> findDistinctSlotsBySemester(@Param("semId") Long semId);

 List<ScheduledClass> findBySubject_IdAndSessionType(
            Long subjectId,
            SessionType sessionType  );

    @Query("""
SELECT s FROM ScheduledClass s
WHERE s.timeSlot.id = :slotId
""")
List<ScheduledClass> findBySlot(Long slotId);

  boolean existsByTimeSlotAndClassroom(TimeSlot slot, Classroom classroom);

    boolean existsByTimeSlotAndTeacherSubjectAllocation_Teacher(
            TimeSlot slot,
            Teacher teacher
    );

    boolean existsByTimeSlotAndDivision(
            TimeSlot slot,
            Division division
    );

}
