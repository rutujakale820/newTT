package com.example.timetabler.repositories;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.timetabler.entities.Substitution;

public interface SubstitutionRepository extends JpaRepository<Substitution, Long> {
}
