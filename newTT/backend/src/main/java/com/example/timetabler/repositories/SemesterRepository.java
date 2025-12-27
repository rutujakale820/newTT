package com.example.timetabler.repositories;

import com.example.timetabler.entities.Semester;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface SemesterRepository extends JpaRepository<Semester, Long> {

    @Query("SELECT s FROM Semester s WHERE s.number IN :numbers")
    List<Semester> findBySemesterNumbers(List<Integer> numbers);

     Optional<Semester> findByNumber(Integer number);

     
}
