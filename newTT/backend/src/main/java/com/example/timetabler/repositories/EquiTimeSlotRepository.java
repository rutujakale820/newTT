package com.example.timetabler.repositories;

import com.example.timetabler.entities.EquiTimeSlot;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EquiTimeSlotRepository
        extends JpaRepository<EquiTimeSlot, Long> {

    List<EquiTimeSlot> findByLabSlot(Long labSlot);

    List<EquiTimeSlot> findByLecSlot(Long lecSlot);
}
