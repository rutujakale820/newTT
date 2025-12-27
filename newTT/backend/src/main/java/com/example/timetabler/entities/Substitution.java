package com.example.timetabler.entities;
import jakarta.persistence.*;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")

@Entity
public class Substitution {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
  private java.sql.Date substitutionDate;
  @ManyToOne private Teacher originalTeacher;
  @ManyToOne private Teacher substituteTeacher;
  @ManyToOne private ScheduledClass scheduledClass;
}
