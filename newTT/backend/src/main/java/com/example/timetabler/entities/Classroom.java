package com.example.timetabler.entities;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

import com.example.timetabler.entities.enums.RoomType;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Classroom {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int capacity;
    private String code;
    
    @Column(name = "part_of")   // 🔥 IMPORTANT
    private String partOf;
    private String name;
    private String roomNumber;

    @Enumerated(EnumType.STRING)
    @Column(name = "room_type", nullable = false)
    private RoomType roomType;

    
}
