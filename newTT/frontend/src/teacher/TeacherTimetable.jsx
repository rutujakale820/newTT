import { useEffect, useState } from "react";
import api from "../api/api";
import "../styles/timetable.css";

const DAYS = ["MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY"];

export default function TeacherTimetable() {
  const [divisionId, setDivisionId] = useState("");
  const [data, setData] = useState([]);
  const [teachers, setTeachers] = useState([]);
  const [selectedTeacher, setSelectedTeacher] = useState("");

  /* Fetch timetable once division is selected */
  useEffect(() => {
    if (!divisionId) return;

    api.get(`/api/dev/student/timetable?divisionId=${divisionId}`)
      .then(res => {
        setData(res.data);

        const uniqueTeachers = [
          ...new Set(res.data.map(d => d.teacherCode))
        ];
        setTeachers(uniqueTeachers);
      });
  }, [divisionId]);

  const filtered = data.filter(
    d => d.teacherCode === selectedTeacher
  );

  return (
    <div style={{ padding: "20px" }}>
      <h2>View Teacher Timetable</h2>

      {/* Division selection */}
      <input
        placeholder="Enter Division ID"
        value={divisionId}
        onChange={(e) => setDivisionId(e.target.value)}
      />

      {/* Teacher dropdown */}
      {teachers.length > 0 && (
        <select
          value={selectedTeacher}
          onChange={(e) => setSelectedTeacher(e.target.value)}
        >
          <option value="">Select Teacher</option>
          {teachers.map(t => (
            <option key={t} value={t}>{t}</option>
          ))}
        </select>
      )}

      {/* Show result */}
      {filtered.map((c, i) => (
        <div key={i}>
          {c.subjectName} – {c.dayOfWeek} – {c.startTime} to {c.endTime}
        </div>
      ))}
    </div>
  );
}
