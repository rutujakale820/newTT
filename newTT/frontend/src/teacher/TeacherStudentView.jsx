import { useEffect, useState } from "react";
import api from "../api/api";
import StudentTimetable from "../student/StudentTimetable";
import "../styles/timetable.css";

export default function TeacherStudentView({ goBack }) {
  const [semesters, setSemesters] = useState([]);
  const [divisions, setDivisions] = useState([]);

  const [semesterId, setSemesterId] = useState("");
  const [divisionId, setDivisionId] = useState("");
  const [divisionName, setDivisionName] = useState("");

  /* LOAD SEMESTERS */
  useEffect(() => {
    api.get("/divisions/semesters")
      .then(res => setSemesters(res.data))
      .catch(() => alert("Failed to load semesters"));
  }, []);

  /* LOAD DIVISIONS */
  const handleSemesterChange = async (e) => {
    const semId = e.target.value;
    setSemesterId(semId);
    setDivisionId("");
    setDivisionName("");
    setDivisions([]);

    if (!semId) return;

    try {
      const res = await api.get(`/divisions/divisions/${semId}`);
      setDivisions(res.data);
    } catch {
      alert("Failed to load divisions");
    }
  };

  return (
    <div className="page-center">
      <button className="back-btn" onClick={goBack}>
        ← Back to Teacher Dashboard
      </button>




        <h1 className="page-heading">View Student Timetable</h1>


      {/* ONLY DROPDOWNS */}
      <div className="login-box wide-box">
        <select value={semesterId} onChange={handleSemesterChange}>
          <option value="">Select Semester</option>
          {semesters.map(s => (
            <option key={s.id} value={s.id}>
              Semester {s.number ?? s.id}
            </option>
          ))}
        </select>

        <select
          value={divisionId}
          disabled={!semesterId}
          onChange={(e) => {
            const id = e.target.value;
            setDivisionId(id);
            const d = divisions.find(x => x.id == id);
            setDivisionName(d?.name || "");
          }}
        >
          <option value="">Select Division</option>
          {divisions.map(d => (
            <option key={d.id} value={d.id}>
              Division {d.name}
            </option>
          ))}
        </select>
      </div>

      {/* TIMETABLE */}
      {divisionId && (
        <div className="timetable-page">
          <StudentTimetable
            divisionId={divisionId}
            semesterId={semesterId}
            divisionName={divisionName}
          />
        </div>
      )}
    </div>
  );
}
