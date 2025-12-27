package com.example.timetabler.repositories;

import com.example.timetabler.entities.Subject;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SubjectRepository extends JpaRepository<Subject, Long> {

    // EVEN semesters (2,4,6,8)
    @Query("""
        SELECT s FROM Subject s
        WHERE MOD(s.semester.number, 2) = 0
    """)
    List<Subject> findEvenSemesterSubjects();

    // ODD semesters (1,3,5,7)
    @Query("""
        SELECT s FROM Subject s
        WHERE MOD(s.semester.number, 2) = 1
    """)
    List<Subject> findOddSemesterSubjects();

    List<Subject> findBySemesterId(Long semesterId);

    @Query("""
        SELECT s FROM Subject s
        WHERE s.semester.number IN :semesterNumbers
    """)
    List<Subject> findBySemesterNumbers(List<Integer> semesterNumbers);

    List<Subject> findBySemesterIdAndElective(Long semesterId, Integer elective);
}
