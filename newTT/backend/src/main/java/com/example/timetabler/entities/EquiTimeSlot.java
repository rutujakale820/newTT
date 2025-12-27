package com.example.timetabler.entities;


import jakarta.persistence.Table;   // ✅ CORRECT

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "equi_time_slot")
public class EquiTimeSlot {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "lab_slot", nullable = false)
    private Long labSlot;

    @Column(name = "lec_slot", nullable = false)
    private Long lecSlot;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getLabSlot() {
        return labSlot;
    }

    public void setLabSlot(Long labSlot) {
        this.labSlot = labSlot;
    }

    public Long getLecSlot() {
        return lecSlot;
    }

    public void setLecSlot(Long lecSlot) {
        this.lecSlot = lecSlot;
    }

    // getters/setters
}
