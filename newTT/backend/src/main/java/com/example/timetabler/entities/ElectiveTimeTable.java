package com.example.timetabler.entities;

import java.util.List;

import org.optaplanner.core.api.domain.solution.PlanningEntityCollectionProperty;
import org.optaplanner.core.api.domain.solution.PlanningScore;
import org.optaplanner.core.api.domain.solution.PlanningSolution;
import org.optaplanner.core.api.domain.valuerange.ValueRangeProvider;
import org.optaplanner.core.api.score.buildin.hardsoft.HardSoftScore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter @Setter
@NoArgsConstructor @AllArgsConstructor @Builder
public class ElectiveTimeTable {

    @PlanningEntityCollectionProperty
    private List<ElectiveDivision> divisions;

    @ValueRangeProvider(id = "teacherRange")
    private List<Teacher> teachers;

    @ValueRangeProvider(id = "timeSlotRange")
    private List<TimeSlot> timeSlots;

    @ValueRangeProvider(id = "classroomRange")
    private List<Classroom> classrooms;

    @PlanningScore
    private HardSoftScore score;
}
