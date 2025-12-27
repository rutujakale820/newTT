package com.example.timetabler.repositories;

import com.example.timetabler.entities.ElectiveGroup;
import com.example.timetabler.entities.ElectiveGroupOption;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ElectiveGroupOptionRepository
        extends JpaRepository<ElectiveGroupOption, Long> {

    
    List<ElectiveGroupOption> findByElectiveGroup(ElectiveGroup parent);

     List<ElectiveGroupOption> findByElectiveGroup_ParentSubject_Id(Long parentSubjectId);
}
