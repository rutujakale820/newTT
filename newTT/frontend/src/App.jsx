import { useState } from "react";
import StudentLogin from "./student/StudentLogin";
import StudentDashboard from "./student/StudentDashboard";
import AdminLogin from "./admin/AdminLogin";
import AdminPanel from "./AdminPanel";

export default function App(){

  const [student, setStudent] = useState(null);
  const [admin, setAdmin] = useState(false);

  const [mode, setMode] = useState("select"); 
  // "select" | "student" | "admin"

  if(mode === "select"){
    return (
      <div style={{textAlign:"center", marginTop:"150px"}}>
        <button onClick={()=>setMode("student")} style={btn}>Student Login</button>
        <button onClick={()=>setMode("admin")} style={btn2}>Admin Login</button>
      </div>
    );
  }

  if(mode === "student" && !student){
    return <StudentLogin onLogin={setStudent} />;
  }

  if(mode === "admin" && !admin){
    return <AdminLogin onAdminLogin={setAdmin} />;
  }

  return (
    <div style={{color:"white"}}>
      {mode === "student" && <StudentDashboard loginData={student} />}
      {mode === "admin" && <AdminPanel />}
    </div>
  );
}

const btn = { padding:"15px", marginRight:"20px" };
const btn2 = { padding:"15px", background:"red", color:"white" };
