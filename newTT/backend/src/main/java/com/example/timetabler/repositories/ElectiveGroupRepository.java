package com.example.timetabler.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.timetabler.entities.ElectiveGroup;

import java.util.List;

public interface ElectiveGroupRepository
        extends JpaRepository<ElectiveGroup, Long> {

    /**
     * ✅ Parent elective subjects for a semester
     */
    @Query("""
        SELECT eg
        FROM ElectiveGroup eg
        JOIN eg.parentSubject s
        WHERE s.semester.id = :semesterId
          AND s.elective = 1
    """)
    List<ElectiveGroup> findElectiveParentsBySemester(
            @Param("semesterId") Long semesterId
    );

    // ❌ DO NOT add student-based filtering here
}
