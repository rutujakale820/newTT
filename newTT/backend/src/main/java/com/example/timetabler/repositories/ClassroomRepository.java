package com.example.timetabler.repositories;

import com.example.timetabler.entities.Classroom;
import com.example.timetabler.entities.enums.RoomType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalTime;
import java.util.List;

public interface ClassroomRepository extends JpaRepository<Classroom, Long> {

    /* ================= FREE CLASSROOMS BY TYPE + SLOT LIST ================= */

    @Query("""
        SELECT c
        FROM Classroom c
        WHERE c.roomType = :type
          AND c.id NOT IN (
              SELECT ed.classroom.id
              FROM ElectiveDivision ed
              WHERE ed.timeSlot.id IN :slotIds
          )
    """)
    List<Classroom> findFreeClassroomsByType(
            @Param("type") RoomType type,
            @Param("slotIds") List<Long> slotIds
    );

    /* ================= FREE CLASSROOM FOR SINGLE SLOT + SEM ================= */

  

    /* ================= BASIC SPRING DATA METHOD ================= */

    

// In ClassroomRepository.java - FIXED VERSION

    
    @Query("""
        SELECT c 
        FROM Classroom c
        WHERE c.roomType = :roomType
          AND c.id NOT IN (
              SELECT ed.classroom.id 
              FROM ElectiveDivision ed
              JOIN ed.timeSlot ts
              WHERE ed.semester.id = :semesterId
                AND ts.dayOfWeek = :dayOfWeek
                AND ts.startTime < :endTime
                AND ts.endTime > :startTime
          )
        ORDER BY c.capacity DESC
    """)
    List<Classroom> findFreeClassroomsForTime(
            @Param("semesterId") Long semesterId,
            @Param("roomType") RoomType roomType,
            @Param("dayOfWeek") Integer dayOfWeek,
            @Param("startTime") LocalTime startTime,
            @Param("endTime") LocalTime endTime);

            

    // In ClassroomRepository.java
@Query("""
    SELECT c 
    FROM Classroom c
    WHERE c.roomType = :roomType
      AND c.id NOT IN (
          SELECT ed.classroom.id 
          FROM ElectiveDivision ed
          WHERE ed.semester.id = :semesterId
            AND ed.timeSlot.dayOfWeek = (
                SELECT ts.dayOfWeek FROM TimeSlot ts WHERE ts.id = :timeSlotId
            )
            AND ed.timeSlot.startTime < (
                SELECT ts.endTime FROM TimeSlot ts WHERE ts.id = :timeSlotId
            )
            AND ed.timeSlot.endTime > (
                SELECT ts.startTime FROM TimeSlot ts WHERE ts.id = :timeSlotId
            )
      )
    ORDER BY c.capacity DESC
""")
List<Classroom> findFreeClassroomsForSlot(
        @Param("timeSlotId") Long timeSlotId,
        @Param("roomType") RoomType roomType,
        @Param("semesterId") Long semesterId);


        // LEC sessions → only LEC rooms
    List<Classroom> findByRoomType(RoomType roomType);

    default List<Classroom> findLectureRooms() {
        return findByRoomType(RoomType.LEC);
    }

    // LAB sessions → only LAB rooms
    default List<Classroom> findLabRooms() {
        return findByRoomType(RoomType.LAB);
    }

    // TUT sessions → ANY room
    default List<Classroom> findAnyRooms() {
        return findAll();
    }

        
}

