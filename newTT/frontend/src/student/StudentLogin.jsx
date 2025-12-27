import { useState } from "react";
import api from "../api/api";

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
    <div style={box}>
      <h2>Student Login</h2>

      <input placeholder="Email" value={email}
        onChange={(e) => setEmail(e.target.value)} style={input} />

      <input type="password" placeholder="Password" value={password}
        onChange={(e) => setPassword(e.target.value)} style={input} />

      <select value={semester}
        onChange={(e) => setSemester(e.target.value)} style={input}>
        <option value="">Select Semester</option>
        {[3,4,5,6,7,8].map(s => (
          <option key={s} value={s}>Semester {s}</option>
        ))}
      </select>

      <select value={division}
        onChange={(e) => setDivision(e.target.value)} style={input}>
        <option value="">Select Division</option>
        {["A","B","C"].map(d => (
          <option key={d} value={d}>Division {d}</option>
        ))}
      </select>

      {error && <p style={{ color: "red" }}>{error}</p>}

      <button onClick={login} style={button}>Login</button>
    </div>
  );
}

const box = {
  width: 320,
  margin: "100px auto",
  padding: 20,
  borderRadius: 10,
  background: "#1e1e1e",
  color: "white",
};

const input = {
  width: "100%",
  padding: 8,
  marginBottom: 10,
};

const button = {
  width: "100%",
  padding: 10,
  background: "#2c3e50",
  color: "white",
  border: "none",
  cursor: "pointer",
};
