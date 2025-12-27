package com.example.timetabler.entities;

import jakarta.persistence.*;
import lombok.*;
import org.optaplanner.core.api.domain.lookup.PlanningId;

import com.example.timetabler.entities.enums.SlotType;

import java.time.LocalTime;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TimeSlot {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @PlanningId
    private Long id;

    private Integer slotNumber;

    private Integer dayOfWeek;

    private LocalTime startTime;
    private LocalTime endTime;

    private boolean lunch;
    private boolean shortBreak;
    
  @Column(nullable = false)
    private String blockCode;
    
   @Enumerated(EnumType.STRING)
@Column(name = "slot_type")
private SlotType slotType;
   // 🔥 LEC / LAB

    private Integer duration;    // 🔥 1 or 2


    
}
