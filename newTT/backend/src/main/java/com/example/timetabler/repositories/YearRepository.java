package com.example.timetabler.repositories;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.timetabler.entities.Year;

public interface YearRepository extends JpaRepository<Year, Long> {
}
