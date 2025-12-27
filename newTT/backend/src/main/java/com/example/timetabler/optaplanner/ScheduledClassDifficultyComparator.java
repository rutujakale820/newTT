package com.example.timetabler.optaplanner;

import com.example.timetabler.entities.ScheduledClass;
import com.example.timetabler.entities.enums.SessionType;

import java.util.Comparator;

public class ScheduledClassDifficultyComparator
        implements Comparator<ScheduledClass> {

    @Override
    public int compare(ScheduledClass a, ScheduledClass b) {

        int da = difficulty(a);
        int db = difficulty(b);

        // Higher difficulty FIRST
        int cmp = Integer.compare(db, da);
        if (cmp != 0) return cmp;

        // Deterministic fallback
        if (a == null || a.getId() == null) return -1;
        if (b == null || b.getId() == null) return 1;

        return a.getId().compareTo(b.getId());
    }

    private int difficulty(ScheduledClass sc) {
        if (sc == null) return 0;

        int score = 0;

        // ----------------------------
        // 1️⃣ Session type difficulty
        // ----------------------------
        if (sc.getSessionType() == SessionType.LAB) {
            score += 100;   // hardest
        } else if (sc.getSessionType() == SessionType.TUT) {
            score += 60;
        } else if (sc.getSessionType() == SessionType.LEC) {
            score += 30;
        }

        // ----------------------------
        // 2️⃣ Batch based sessions
        // ----------------------------
        if (sc.getBatch() != null) {
            score += 40;   // labs/tuts are harder
        }

        // ----------------------------
        // 3️⃣ Default base weight
        // ----------------------------
        score += 10;

        return score;
    }
}
