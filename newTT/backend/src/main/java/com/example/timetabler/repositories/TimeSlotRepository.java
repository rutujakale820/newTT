package com.example.timetabler.repositories;

import com.example.timetabler.entities.TimeSlot;
import com.example.timetabler.entities.enums.SessionType;
import com.example.timetabler.entities.enums.SlotType;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TimeSlotRepository extends JpaRepository<TimeSlot, Long> {

    

@Query("""
        select ts
        from TimeSlot ts
        where ts.slotType = :slotType
          and ts.lunch = false
          and ts.shortBreak = false
        order by ts.dayOfWeek, ts.startTime
    """)
    List<TimeSlot> findSlotsBySlotType(
            @Param("slotType") SlotType slotType
    );

    @Query("""
        SELECT ts
        FROM TimeSlot ts
        WHERE ts.lunch = false
          AND ts.shortBreak = false
    """)
    List<TimeSlot> findTeachingSlots();

    

    @Query("""
        SELECT ts FROM TimeSlot ts
        WHERE ts.slotType = com.example.timetabler.entities.enums.SlotType.LEC
          AND ts.lunch = false
          AND ts.shortBreak = false
    """)
    List<TimeSlot> findLectureSlots();

    /* LAB slots */
    @Query("""
        SELECT ts FROM TimeSlot ts
        WHERE ts.slotType = com.example.timetabler.entities.enums.SlotType.LAB
    """)
    List<TimeSlot> findLabSlots();


    
}
