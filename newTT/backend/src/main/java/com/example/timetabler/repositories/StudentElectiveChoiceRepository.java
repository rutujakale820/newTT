package com.example.timetabler.repositories;

import com.example.timetabler.entities.ElectiveGroupOption;
import com.example.timetabler.entities.StudentElectiveChoice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StudentElectiveChoiceRepository
        extends JpaRepository<StudentElectiveChoice, Long> {

     @Query("""
        SELECT DISTINCT sec.chosenOption
        FROM StudentElectiveChoice sec
    """)
    List<ElectiveGroupOption> findChosenOptions();


   @Query("""
    select ego
    from ElectiveGroupOption ego
    join ego.electiveGroup eg
    join eg.parentSubject s
    where s.elective = 1
      and s.semester.id = :semesterId
""")
List<ElectiveGroupOption> findElectiveOptionsBySemester(Long semesterId);

    @Query("""
        SELECT DISTINCT sec.chosenOption
        FROM StudentElectiveChoice sec
        WHERE sec.parentElective.semester.id = :semesterId
    """)
    List<ElectiveGroupOption> findChosenOptionsBySemester(
            @Param("semesterId") Long semesterId
    );

    /* ✅ Total students for an option */
    @Query("""
        SELECT COALESCE(SUM(sec.count), 0)
        FROM StudentElectiveChoice sec
        WHERE sec.chosenOption.id = :optionId
    """)
    int findTotalStudentsForOption(
            @Param("optionId") Long optionId
    );

    @Query("""
        SELECT COALESCE(SUM(sec.count), 0)
        FROM StudentElectiveChoice sec
        WHERE sec.chosenOption.id = :optionId
    """)
    int sumCountByChosenOption(@Param("optionId") Long optionId);
}
