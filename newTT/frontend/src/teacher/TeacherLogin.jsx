import { useState } from "react";
import axios from "axios";
import "../styles/login.css";   // IMPORTANT


export default function TeacherLogin({ onLogin }) {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const handleLogin = async () => {
    try {
      const res = await axios.post(
        "http://localhost:8080/api/dev/teacher/login",
        { email, password }
      );

      if (res.data.status === "OK") {
        onLogin();
      } else {
        alert(res.data.message);
      }
    } catch {
      alert("Login failed");
    }
  };

  return (
    <div className="login-container">
      <div className="login-box">
        <h2>Teacher Login</h2>

        <input
          type="email"
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

        <button className="teacher-btn" onClick={handleLogin}>
          Login
        </button>
      </div>
    </div>
  );
}
