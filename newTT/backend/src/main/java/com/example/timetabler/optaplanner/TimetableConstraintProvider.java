package com.example.timetabler.optaplanner;

import com.example.timetabler.entities.*;
import com.example.timetabler.entities.enums.SessionType;
import com.example.timetabler.optaplanner.facts.SlotBlock;

import org.optaplanner.core.api.score.buildin.hardsoft.HardSoftScore;
import org.optaplanner.core.api.score.stream.*;

import java.util.List;

public class TimetableConstraintProvider implements ConstraintProvider {

    @Override
    public Constraint[] defineConstraints(ConstraintFactory factory) {

        return new Constraint[]{

                /* ========= HARD CONSTRAINTS ========= */

                nonElectiveMustBeFullyAssigned(factory),


                /* 🔒 ELECTIVE LOCKS */
                slotBlockConstraint(factory),

                teacherSameSlotConflict(factory),
                classroomSameSlotConflict(factory),
                divisionSameSlotConflict(factory),
                batchSameSlotConflict(factory),
                oneTeacherPerSubjectPerDivisionForLecture(factory),
                maxTwoDivisionsPerTeacherPerSubject(factory),
                
                teacherEquiTimeSlotConflict(factory),
                classroomEquiTimeSlotConflict(factory),
                divisionEquiTimeSlotConflict(factory),
                batchEquiTimeSlotConflict(factory),
                maxOneLabPerDayPerDivisionSoft(factory),

                oneSubjectOneSlotPerDayDivision(factory),
                oneSubjectOneSlotPerDayBatch(factory),

                maxWeeklyLoad(factory),
                maxHoursPerDay(factory),
                maxContinuousHours(factory),

                /* ========= SOFT CONSTRAINTS ========= */

                teacherLoadBalancing(factory),
                minimizeLectureIdleTime(factory),
                minimizeBatchIdleTime(factory),
                minimizeLectureClassroomMigration(factory),
               
        };
    }

    /* =====================================================
       ELECTIVE
       ===================================================== */

       private boolean sameOrEqui(
        TimeSlot a,
        TimeSlot b,
        List<EquiTimeSlot> equiSlots) {

    if (a.equals(b)) return true;

    for (EquiTimeSlot eq : equiSlots) {
        if ((eq.getLabSlot().equals(a.getId()) && eq.getLecSlot().equals(b.getId()))
         || (eq.getLabSlot().equals(b.getId()) && eq.getLecSlot().equals(a.getId()))) {
            return true;
        }
    }
    return false;
}

    private Constraint slotBlockConstraint(ConstraintFactory factory) {

    return factory.forEach(ScheduledClass.class)

        /* ONLY REGULAR CLASSES */
        .filter(sc ->
            sc.getElectiveFlag() == 0 &&
            sc.getTimeSlot() != null &&
            sc.getTimetable() != null
        )

        .join(SlotBlock.class)

        .filter((sc, block) -> {

            /* ---------- SLOT OR EQUI SLOT ---------- */
            if (!sameOrEqui(
                    sc.getTimeSlot(),
                    block.getTimeSlot(),
                    sc.getTimetable().getEquiTimeSlotList()
            )) {
                return false;
            }

            /* ---------- RULE-A: SLOT LOCK (semester-wise) ---------- */
            boolean slotBlockedForSemester =
                block.getSemester() != null &&
                block.getSemester().equals(sc.getSemester());

            /* ---------- RULE-B: TEACHER GLOBAL LOCK ---------- */
            boolean teacherBlocked =
                block.getTeacher() != null &&
                sc.getTeacherSubjectAllocation() != null &&
                block.getTeacher().equals(
                    sc.getTeacherSubjectAllocation().getTeacher()
                );

            /* ---------- RULE-C: CLASSROOM GLOBAL LOCK ---------- */
            boolean classroomBlocked =
                block.getClassroom() != null &&
                block.getClassroom().equals(sc.getClassroom());

            /* ---------- FINAL DECISION ---------- */
            return slotBlockedForSemester
                || teacherBlocked
                || classroomBlocked;
        })

        .penalize(HardSoftScore.ONE_HARD)
        .asConstraint(
            "Elective slot lock: semester-slot OR global teacher/classroom"
        );
}




    /* =====================================================
       BASIC SAFETY
       ===================================================== */

       private Constraint maxOneLabPerDayPerDivisionSoft(ConstraintFactory factory) {

    return factory.forEach(ScheduledClass.class)
            .filter(sc ->
                    sc.getSessionType() == SessionType.LAB &&
                    sc.getDivision() != null &&
                    sc.getTimeSlot() != null
            )
            .groupBy(
                    ScheduledClass::getDivision,
                    sc -> sc.getTimeSlot().getDayOfWeek(),
                    ConstraintCollectors.countDistinct(
                            sc -> sc.getTimeSlot().getId()
                    )
            )
            .filter((division, day, distinctLabSlots) ->
                    distinctLabSlots > 1
            )
            .penalize(
                    HardSoftScore.ofSoft(20),   // 🔥 HIGH SOFT WEIGHT
                    (division, day, distinctLabSlots) ->
                            distinctLabSlots - 1
            )
            .asConstraint("SOFT: max one LAB slot per day per division");
}


    private Constraint nonElectiveMustBeFullyAssigned(
            ConstraintFactory factory) {

        return factory.forEach(ScheduledClass.class)
                .filter(sc ->
                        sc.getElectiveFlag() == 0 &&
                        (sc.getTeacherSubjectAllocation() == null
                                || sc.getClassroom() == null
                                || sc.getTimeSlot() == null)
                )
                .penalize(HardSoftScore.ONE_HARD)
                .asConstraint("Non-elective must be fully assigned");
    }

    /* =====================================================
       SAME SLOT CONFLICTS
       ===================================================== */
       
    private Constraint teacherSameSlotConflict(
            ConstraintFactory factory) {

        return factory.forEach(ScheduledClass.class)
                .filter(sc -> sc.getTeacher() != null && sc.getTimeSlot() != null)
                .groupBy(
                        ScheduledClass::getTeacher,
                        ScheduledClass::getTimeSlot,
                        ConstraintCollectors.count()
                )
                .filter((teacher, slot, count) -> count > 1)
                .penalize(HardSoftScore.ONE_HARD)
                .asConstraint("Teacher same slot conflict");
    }

    private Constraint classroomSameSlotConflict(
            ConstraintFactory factory) {

        return factory.forEach(ScheduledClass.class)
                .filter(sc -> sc.getClassroom() != null && sc.getTimeSlot() != null)
                .groupBy(
                        ScheduledClass::getClassroom,
                        ScheduledClass::getTimeSlot,
                        ConstraintCollectors.count()
                )
                .filter((room, slot, count) -> count > 1)
                .penalize(HardSoftScore.ONE_HARD)
                .asConstraint("Classroom same slot conflict");
    }

    private Constraint divisionSameSlotConflict(
        ConstraintFactory factory) {

    return factory.forEach(ScheduledClass.class)
            .filter(sc ->
                    sc.getDivision() != null &&
                    sc.getTimeSlot() != null
            )
            .groupBy(
                    ScheduledClass::getDivision,
                    ScheduledClass::getTimeSlot,
                    ConstraintCollectors.count()
            )
            .filter((division, slot, count) -> count > 1)
            .penalize(HardSoftScore.ONE_HARD)
            .asConstraint("Division same slot – no overlap at all");
}

private Constraint batchEquiTimeSlotConflict(ConstraintFactory factory) {

    return factory.forEachUniquePair(
                    ScheduledClass.class,
                    Joiners.equal(ScheduledClass::getBatch)
            )
            .filter((a, b) ->
                    a.getBatch() != null &&
                    a.getTimeSlot() != null &&
                    b.getTimeSlot() != null &&
                    equiOverlap(
                            a.getTimeSlot().getId(),
                            b.getTimeSlot().getId(),
                            a.getTimetable().getEquiTimeSlotList()
                    )
            )
            .penalize(HardSoftScore.ONE_HARD)
            .asConstraint("Batch equi time slot conflict");
}



private Constraint minimizeLectureIdleTime(ConstraintFactory factory) {

    return factory.forEach(ScheduledClass.class)
            .filter(sc ->
                    sc.getSessionType() == SessionType.LEC &&
                    sc.getDivision() != null &&
                    sc.getTimeSlot() != null
            )
            .join(
                    ScheduledClass.class,
                    Joiners.equal(ScheduledClass::getDivision),
                    Joiners.equal(sc -> sc.getTimeSlot().getDayOfWeek()),
                    Joiners.lessThan(
                            sc -> sc.getTimeSlot().getStartTime(),
                            sc -> sc.getTimeSlot().getStartTime()
                    )
            )
            .filter((a, b) ->
                    a.getSessionType() == SessionType.LEC &&
                    b.getSessionType() == SessionType.LEC
            )
            .penalize(
                    HardSoftScore.ONE_SOFT,
                    (a, b) -> {
                        long gap =
                                java.time.Duration.between(
                                        a.getTimeSlot().getEndTime(),
                                        b.getTimeSlot().getStartTime()
                                ).toMinutes();
                        return (int) Math.max(0, gap);
                    }
            )
            .asConstraint("Minimize lecture idle time (migration)");
}

private Constraint minimizeBatchIdleTime(ConstraintFactory factory) {

    return factory.forEach(ScheduledClass.class)
            .filter(sc ->
                    sc.getBatch() != null &&
                    sc.getTimeSlot() != null
            )
            .join(
                    ScheduledClass.class,
                    Joiners.equal(ScheduledClass::getBatch),
                    Joiners.equal(sc -> sc.getTimeSlot().getDayOfWeek()),
                    Joiners.lessThan(
                            sc -> sc.getTimeSlot().getStartTime(),
                            sc -> sc.getTimeSlot().getStartTime()
                    )
            )
            .filter((a, b) ->
                    a.getTimeSlot().getEndTime().isBefore(b.getTimeSlot().getStartTime())
            )
            .penalize(
                    HardSoftScore.ONE_SOFT,
                    (a, b) -> (int)
                            java.time.Duration.between(
                                    a.getTimeSlot().getEndTime(),
                                    b.getTimeSlot().getStartTime()
                            ).toMinutes()
            )
            .asConstraint("Minimize batch idle time");
}


private Constraint minimizeLectureClassroomMigration(ConstraintFactory factory) {

    return factory.forEach(ScheduledClass.class)
            .filter(sc ->
                    sc.getSessionType() == SessionType.LEC &&
                    sc.getDivision() != null &&
                    sc.getTimeSlot() != null &&
                    sc.getClassroom() != null
            )
            .join(
                    ScheduledClass.class,
                    Joiners.equal(ScheduledClass::getDivision),
                    Joiners.equal(sc -> sc.getTimeSlot().getDayOfWeek()),
                    Joiners.equal(sc -> sc.getTimeSlot().getEndTime(),
                                  sc -> sc.getTimeSlot().getStartTime())
            )
            .filter((a, b) ->
                    a.getClassroom() != null &&
                    b.getClassroom() != null &&
                    !a.getClassroom().getId().equals(b.getClassroom().getId())
            )
            .penalize(HardSoftScore.ONE_SOFT)
            .asConstraint("Minimize lecture classroom migration");
}



    private Constraint batchSameSlotConflict(
            ConstraintFactory factory) {

        return factory.forEach(ScheduledClass.class)
                .filter(sc -> sc.getBatch() != null && sc.getTimeSlot() != null)
                .groupBy(
                        ScheduledClass::getBatch,
                        ScheduledClass::getTimeSlot,
                        ConstraintCollectors.count()
                )
                .filter((batch, slot, count) -> count > 1)
                .penalize(HardSoftScore.ONE_HARD)
                .asConstraint("Batch same slot conflict");
    }

    private Constraint divisionEquiTimeSlotConflict(ConstraintFactory factory) {

    return factory.forEachUniquePair(
            ScheduledClass.class,
            Joiners.equal(ScheduledClass::getDivision)
    )
    .filter((a, b) ->
            a.getDivision() != null &&
            a.getTimeSlot() != null &&
            b.getTimeSlot() != null &&

            // 🔥 only block if one of them is LEC
            (a.getSessionType() == SessionType.LEC
             || b.getSessionType() == SessionType.LEC) &&

            // 🔥 equi-slot overlap (LAB↔LEC, LAB↔TUT)
            equiOverlap(
                    a.getTimeSlot().getId(),
                    b.getTimeSlot().getId(),
                    a.getTimetable().getEquiTimeSlotList()
            )
    )
    .penalize(HardSoftScore.ONE_HARD)
    .asConstraint("Division equi-slot conflict (LEC only)");
}



    /* =====================================================
       EQUI TIMESLOT CONFLICTS (LAB ↔ LEC)
       ===================================================== */

    private Constraint teacherEquiTimeSlotConflict(
            ConstraintFactory factory) {

        return factory.forEachUniquePair(
                        ScheduledClass.class,
                        Joiners.equal(ScheduledClass::getTeacher)
                )
                .filter((a, b) ->
                        a.getTeacher() != null &&
                        a.getTimeSlot() != null &&
                        b.getTimeSlot() != null &&
                        equiOverlap(
                                a.getTimeSlot().getId(),
                                b.getTimeSlot().getId(),
                                a.getTimetable().getEquiTimeSlotList()
                        )
                )
                .penalize(HardSoftScore.ONE_HARD)
                .asConstraint("Teacher equi-timeslot conflict");
    }

    private Constraint classroomEquiTimeSlotConflict(
            ConstraintFactory factory) {

        return factory.forEachUniquePair(
                        ScheduledClass.class,
                        Joiners.equal(ScheduledClass::getClassroom)
                )
                .filter((a, b) ->
                        a.getClassroom() != null &&
                        a.getTimeSlot() != null &&
                        b.getTimeSlot() != null &&
                        equiOverlap(
                                a.getTimeSlot().getId(),
                                b.getTimeSlot().getId(),
                                a.getTimetable().getEquiTimeSlotList()
                        )
                )
                .penalize(HardSoftScore.ONE_HARD)
                .asConstraint("Classroom equi-timeslot conflict");
    }

    /* =====================================================
       SUBJECT DISTRIBUTION
       ===================================================== */
       private Constraint oneTeacherPerSubjectPerDivisionForLecture(
        ConstraintFactory factory) {

    return factory.forEach(ScheduledClass.class)
            .filter(sc ->
                    sc.getSessionType() == SessionType.LEC &&
                    sc.getDivision() != null &&
                    sc.getTeacher() != null
            )
            .groupBy(
                    ScheduledClass::getDivision,
                    ScheduledClass::getSubject,
                    ConstraintCollectors.countDistinct(
                            ScheduledClass::getTeacher
                    )
            )
            .filter((division, subject, teacherCount) -> teacherCount > 1)
            .penalize(HardSoftScore.ONE_HARD)
            .asConstraint("One teacher per subject per division (LEC)");
}

private Constraint maxTwoDivisionsPerTeacherPerSubject(
        ConstraintFactory factory) {

    return factory.forEach(ScheduledClass.class)
            .filter(sc ->
                    sc.getSessionType() == SessionType.LEC &&
                    sc.getDivision() != null &&
                    sc.getTeacher() != null
            )
            .groupBy(
                    ScheduledClass::getSubject,
                    ScheduledClass::getTeacher,
                    ConstraintCollectors.countDistinct(
                            ScheduledClass::getDivision
                    )
            )
            .filter((subject, teacher, divisionCount) ->
                    divisionCount > 2
            )
            .penalize(HardSoftScore.ONE_HARD)
            .asConstraint("Max 2 divisions per teacher per subject (LEC)");
}



    private Constraint oneSubjectOneSlotPerDayDivision(
            ConstraintFactory factory) {

        return factory.forEach(ScheduledClass.class)
                .filter(sc ->
                        sc.getSessionType() == SessionType.LEC &&
                        sc.getDivision() != null &&
                        sc.getTimeSlot() != null
                )
                .groupBy(
                        ScheduledClass::getSubject,
                        ScheduledClass::getDivision,
                        sc -> sc.getTimeSlot().getDayOfWeek(),
                        ConstraintCollectors.count()
                )
                .filter((sub, div, day, count) -> count > 1)
                .penalize(HardSoftScore.ONE_HARD)
                .asConstraint("One subject one lecture per day per division");
    }

    private Constraint oneSubjectOneSlotPerDayBatch(
            ConstraintFactory factory) {

        return factory.forEach(ScheduledClass.class)
                .filter(sc ->
                        sc.getBatch() != null &&
                        sc.getTimeSlot() != null
                )
                .groupBy(
                        ScheduledClass::getSubject,
                        ScheduledClass::getBatch,
                        sc -> sc.getTimeSlot().getDayOfWeek(),
                        ConstraintCollectors.count()
                )
                .filter((sub, batch, day, count) -> count > 1)
                .penalize(HardSoftScore.ONE_HARD)
                .asConstraint("One subject one slot per day per batch");
    }

    /* =====================================================
       TEACHER LOAD LIMITS (DB DRIVEN)
       ===================================================== */

    private Constraint maxWeeklyLoad(
        ConstraintFactory factory) {

    return factory.forEach(ScheduledClass.class)
            .filter(sc -> sc.getTeacher() != null)
            .groupBy(
                    ScheduledClass::getTeacher,
                    ConstraintCollectors.sum(
                            sc -> sc.getSessionType() == SessionType.LAB ? 2 : 1
                    )
            )
            .filter((teacher, totalHours) ->
                    teacher.getMaxWeeklyLoad() != null &&
                    totalHours > teacher.getMaxWeeklyLoad()
            )
            .penalize(
                    HardSoftScore.ONE_HARD,
                    (teacher, totalHours) ->
                            totalHours - teacher.getMaxWeeklyLoad()
            )
            .asConstraint("Teacher max weekly load (HOURS)");
}


    private Constraint maxHoursPerDay(
            ConstraintFactory factory) {

        return factory.forEach(ScheduledClass.class)
                .filter(sc ->
                        sc.getTeacher() != null &&
                        sc.getTimeSlot() != null
                )
                .groupBy(
                        ScheduledClass::getTeacher,
                        sc -> sc.getTimeSlot().getDayOfWeek(),
                        ConstraintCollectors.count()
                )
                .filter((teacher, day, count) ->
                        teacher.getMaxHoursPerDay() != null &&
                        count > teacher.getMaxHoursPerDay()
                )
                .penalize(
                        HardSoftScore.ONE_HARD,
                        (teacher, day, count) ->
                                count - teacher.getMaxHoursPerDay()
                )
                .asConstraint("Teacher max hours per day");
    }

    private Constraint maxContinuousHours(
        ConstraintFactory factory) {

    return factory.forEach(ScheduledClass.class)
            .filter(sc ->
                    sc.getTeacher() != null &&
                    sc.getTimeSlot() != null &&
                    sc.getTeacher().getMaxContinuousHours() != null
            )
            .groupBy(
                    ScheduledClass::getTeacher,
                    sc -> sc.getTimeSlot().getDayOfWeek(),
                    ConstraintCollectors.count()
            )
            .filter((teacher, day, count) ->
                    count > teacher.getMaxContinuousHours()
            )
            .penalize(HardSoftScore.ONE_HARD)
            .asConstraint("Teacher max continuous hours");
}


    /* =====================================================
       SOFT LOAD BALANCING
       ===================================================== */

    private Constraint teacherLoadBalancing(
            ConstraintFactory factory) {

        return factory.forEach(ScheduledClass.class)
                .filter(sc -> sc.getTeacher() != null)
                .groupBy(
                        ScheduledClass::getTeacher,
                        ConstraintCollectors.count()
                )
                .penalize(
                        HardSoftScore.ONE_SOFT,
                        (teacher, count) -> Math.abs(count - 5)
                )
                .asConstraint("Teacher load balancing");
    }

    /* =====================================================
       HELPERS
       ===================================================== */

    private boolean equiOverlap(
            Long slotA,
            Long slotB,
            List<EquiTimeSlot> equiSlots) {

        if (slotA.equals(slotB)) return false;

        for (EquiTimeSlot eq : equiSlots) {
            if ((eq.getLabSlot().equals(slotA) && eq.getLecSlot().equals(slotB))
             || (eq.getLabSlot().equals(slotB) && eq.getLecSlot().equals(slotA))) {
                return true;
            }
        }
        return false;
    }

    private boolean areConsecutive(TimeSlot t1, TimeSlot t2) {
        return t1.getEndTime().equals(t2.getStartTime())
            || t2.getEndTime().equals(t1.getStartTime());
    }


}
