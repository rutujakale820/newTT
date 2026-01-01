import { useState } from "react";

import StudentLogin from "./student/StudentLogin";
import StudentDashboard from "./student/StudentDashboard";

import AdminLogin from "./admin/AdminLogin";
import AdminPanel from "./AdminPanel";

import TeacherLogin from "./teacher/TeacherLogin";
import TeacherHome from "./teacher/TeacherHome";
import TeacherStudentView from "./teacher/TeacherStudentView";
import TeacherTimetable from "./teacher/TeacherTimetable";

import "./App.css";

export default function App() {
  const [mode, setMode] = useState("select");

  const [student, setStudent] = useState(null);
  const [adminLoggedIn, setAdminLoggedIn] = useState(false);

  const [teacherLoggedIn, setTeacherLoggedIn] = useState(false);
  const [teacherMode, setTeacherMode] = useState(null);

  /* ================= LANDING ================= */
  if (mode === "select") {
    return (
      <div className="landing">
        <h1 className="landing-title">Timetable Management System</h1>
        <p className="landing-subtitle">
          Smart scheduling for students and administrators
        </p>

        <div className="landing-buttons">
          <button onClick={() => setMode("student")}>Student Login</button>
          <button onClick={() => setMode("admin")}>Admin Login</button>
          <button onClick={() => setMode("teacher")}>Teacher Login</button>
        </div>
      </div>
    );
  }

  /* ================= STUDENT ================= */
  if (mode === "student" && !student) {
    return <StudentLogin onLogin={setStudent} />;
  }

  if (mode === "student" && student) {
    return <StudentDashboard loginData={student} />;
  }

  /* ================= ADMIN ================= */
  if (mode === "admin" && !adminLoggedIn) {
    return <AdminLogin onAdminLogin={() => setAdminLoggedIn(true)} />;
  }

  if (mode === "admin" && adminLoggedIn) {
    return <AdminPanel />;
  }

  /* ================= TEACHER ================= */
  if (mode === "teacher" && !teacherLoggedIn) {
    return <TeacherLogin onLogin={() => setTeacherLoggedIn(true)} />;
  }

  if (mode === "teacher" && teacherLoggedIn && teacherMode === null) {
    return <TeacherHome onSelect={setTeacherMode} />;
  }

  if (mode === "teacher" && teacherMode === "studentTT") {
    return (
      <TeacherStudentView
        goBack={() => setTeacherMode(null)}
      />
    );
  }

  if (mode === "teacher" && teacherMode === "teacherTT") {
    return (
      <TeacherTimetable
        goBack={() => setTeacherMode(null)}
      />
    );
  }

  return null;
}
