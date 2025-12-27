package com.example.timetabler.optaplanner;

import com.example.timetabler.entities.ScheduledClass;
import com.example.timetabler.entities.Timetable;
import com.example.timetabler.optaplanner.TimetableConstraintProvider;
import org.optaplanner.core.api.solver.SolverFactory;
import org.optaplanner.core.config.solver.SolverConfig;
import org.optaplanner.core.config.score.director.ScoreDirectorFactoryConfig;
import org.optaplanner.core.config.solver.termination.TerminationConfig;

public class TimetableSolver {

    public static SolverFactory<Timetable> solverFactory(int seconds) {

        return SolverFactory.create(
            new SolverConfig()
                .withSolutionClass(Timetable.class)
                .withEntityClasses(ScheduledClass.class)
                .withScoreDirectorFactory(
                    new ScoreDirectorFactoryConfig()
                        .withConstraintProviderClass(
                            TimetableConstraintProvider.class
                        )
                )
                .withTerminationConfig(
                    new TerminationConfig()
                        .withSecondsSpentLimit((long) seconds)
                )
        );
    }
}
