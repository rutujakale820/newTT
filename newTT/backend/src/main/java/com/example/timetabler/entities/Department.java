package com.example.timetabler.entities;
import jakarta.persistence.*;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity

@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")

public class Department {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
  @Column(unique=true) private String code;
  private String name;
  // getters setters
  public Long getId(){return id;} public void setId(Long id){this.id=id;}
  public String getCode(){return code;} public void setCode(String c){this.code=c;}
  public String getName(){return name;} public void setName(String n){this.name=n;}
}
