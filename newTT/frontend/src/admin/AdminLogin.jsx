import { useState } from "react";
import api from "../api/api";
import "../styles/timetable.css";

export default function AdminLogin({ onAdminLogin }) {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");

  const login = async () => {
    setError("");

    try {
      const res = await api.post("/admin/login", { email, password });

      if (res.data.status === "OK") {
        localStorage.setItem("adminLoggedIn", "true");
        onAdminLogin(true);
      } else {
        setError(res.data.message);
      }
    } catch {
      setError("Login failed");
    }
  };

  return (
    <div className="login-container">
      <div className="login-box admin">
        <h2>Admin Login</h2>

        <input
          type="email"
          placeholder="Email"
          value={email}
          onChange={e => setEmail(e.target.value)}
        />

        <input
          type="password"
          placeholder="Password"
          value={password}
          onChange={e => setPassword(e.target.value)}
        />

        {error && <p className="error">{error}</p>}

        <button className="admin-btn" onClick={login}>
          Login
        </button>
      </div>
    </div>
  );
}
