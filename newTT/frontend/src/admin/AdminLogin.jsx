import { useState } from "react";
import api from "../api/api";

export default function AdminLogin({ onAdminLogin }) {

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");

  const login = async () => {
    setError("");

    try {
      const res = await api.post("/admin/login", { email, password });

      if(res.data.status === "OK"){
        onAdminLogin(true);
      } else {
        setError(res.data.message);
      }

    } catch {
      setError("Login failed");
    }
  };

  return (
    <div style={box}>
      <h2>Admin Login</h2>

      <input
        placeholder="Email"
        value={email}
        onChange={(e)=>setEmail(e.target.value)}
        style={input}
      />

      <input
        type="password"
        placeholder="Password"
        value={password}
        onChange={(e)=>setPassword(e.target.value)}
        style={input}
      />

      {error && <p style={{color:"red"}}>{error}</p>}

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
  background: "#ff5e5e",
  color: "white",
  border: "none",
  cursor: "pointer",
};
