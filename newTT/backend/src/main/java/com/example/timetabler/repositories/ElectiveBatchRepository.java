package com.example.timetabler.repositories;

import com.example.timetabler.entities.ElectiveBatch;

import jakarta.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ElectiveBatchRepository extends JpaRepository<ElectiveBatch, Long> {

    @Modifying
    @Query("DELETE FROM ElectiveBatch")
    void deleteAllBatches();

   @Modifying
    @Transactional
    @Query("""
        delete from ElectiveBatch eb
        where eb.electiveDivision.semester.id = :semesterId
    """)
    void deleteBySemesterId(@Param("semesterId") Long semesterId);


}
