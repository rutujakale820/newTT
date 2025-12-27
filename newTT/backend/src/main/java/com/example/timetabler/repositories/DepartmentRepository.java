package com.example.timetabler.repositories;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.timetabler.entities.Department;

public interface DepartmentRepository extends JpaRepository<Department, Long> {
}
