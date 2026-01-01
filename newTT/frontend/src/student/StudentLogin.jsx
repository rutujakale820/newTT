import { useState } from "react";
import api from "../api/api";
import "../styles/login.css";   // 🔥 IMPORTANT

export default function StudentLogin({ onLogin }) {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [semester, setSemester] = useState("");
  const [division, setDivision] = useState("");
  const [error, setError] = useState("");

  const login = () => {
    setError("");

    api
      .post("/login", {
        email,
        password,
        semesterId: semester,
        divisionName: division,
      })
      .then((res) => {
        if (res.data.status === "OK") {
          onLogin(res.data);
        } else {
          setError(res.data.message);
        }
      })
      .catch(() => setError("Invalid credentials"));
  };

  return (
    <div className="login-container">
    <div className="login-box">
      <h2>Student Login</h2>

        <input
          placeholder="Email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />

        <input
          type="password"
          placeholder="Password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />

        <select value={semester} onChange={(e) => setSemester(e.target.value)}>
          <option value="">Select Semester</option>
          {[3, 4, 5, 6, 7, 8].map((s) => (
            <option key={s} value={s}>
              Semester {s}
            </option>
          ))}
        </select>

        <select value={division} onChange={(e) => setDivision(e.target.value)}>
          <option value="">Select Division</option>
          {["A", "B", "C"].map((d) => (
            <option key={d} value={d}>
              Division {d}
            </option>
          ))}
        </select>

        {error && <p className="error">{error}</p>}

        <button className="student-btn" onClick={login}>
          Login
        </button>
      </div>
    </div>
  );
}
