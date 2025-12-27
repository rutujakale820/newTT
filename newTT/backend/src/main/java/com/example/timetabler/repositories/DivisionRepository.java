package com.example.timetabler.repositories;
import java.util.Optional;

import com.example.timetabler.entities.Division;
import com.example.timetabler.entities.Semester;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface DivisionRepository extends JpaRepository<Division, Long> {

    List<Division> findBySemester_NumberIn(List<Integer> numbers);

    List<Division> findBySemester(Semester semester);

    List<Division> findBySemesterId(Long semesterId);

    @Query("""
        SELECT d
        FROM Division d
        WHERE MOD(d.semester.id, 2) = :parity
        ORDER BY d.semester.id, d.name
    """)
    List<Division> findBySemesterParity(@Param("parity") int parity);

@Query("""
    SELECT d
    FROM Division d
    WHERE d.semester.id IN :semesterIds
    ORDER BY d.semester.id, d.name
""")
List<Division> findBySemesterIds(@Param("semesterIds") List<Long> semesterIds);


Optional<Division> findBySemesterIdAndName(
            Integer semesterId,
            String name
    );

}
