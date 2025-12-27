import StudentTimetable from "./StudentTimetable";

export default function StudentDashboard({ loginData }) {
  return (
    <div style={{ padding: 20 }}>
      <h2>
        Semester {loginData.semesterId} – Division {loginData.divisionName}
      </h2>

      <StudentTimetable divisionId={loginData.divisionId} />
    </div>
  );
}
