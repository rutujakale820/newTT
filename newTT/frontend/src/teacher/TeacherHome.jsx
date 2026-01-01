export default function TeacherHome({ onSelect }) {
  return (
    <div className="landing">
      <h1 className="landing-title">Teacher </h1>
      <p className="landing-subtitle">
        Choose what you want to view
      </p>

      <div className="landing-buttons">
        <button onClick={() => onSelect("studentTT")}>
          View Student Timetable
        </button>
        <button onClick={() => onSelect("teacherTT")}>
          View My Timetable
        </button>
       

      </div>
    </div>
  );
}
