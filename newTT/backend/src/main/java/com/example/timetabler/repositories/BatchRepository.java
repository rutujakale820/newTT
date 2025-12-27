package com.example.timetabler.repositories;

import com.example.timetabler.entities.Batch;
import com.example.timetabler.entities.Division;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface BatchRepository extends JpaRepository<Batch, Long> {

    List<Batch> findByDivisionId(Long divisionId);
    List<Batch> findByDivision(Division division);

    List<Batch> findByDivisionIdIn(List<Long> divisionIds);  // ⭐ ADD THIS
}
