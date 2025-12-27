package com.example.timetabler.repositories;

import com.example.timetabler.entities.ElectiveOption;
import com.example.timetabler.entities.Teacher;

import com.example.timetabler.entities.ElectiveGroupOption;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ElectiveOptionRepository
        extends JpaRepository<ElectiveOption, Long> {

    /**
     * option_subject_id → ElectiveGroupOption.id
     */
    @Query("""
        SELECT eo.preferredTeacher.id
        FROM ElectiveOption eo
        WHERE eo.optionSubject.id = :optionId
    """)
    List<Long> findTeacherIdsByOptionId(@Param("optionId") Long optionId);

    @Query("""
        SELECT t
        FROM Teacher t
        JOIN ElectiveOption eo
             ON eo.preferredTeacher.id = t.id
        WHERE eo.groupOption.id = :optionId
    """)
    List<Teacher> findTeachersByOptionId(@Param("optionId") Long optionId);

      List<ElectiveOption> findByGroupOption(ElectiveGroupOption groupOption);
}
