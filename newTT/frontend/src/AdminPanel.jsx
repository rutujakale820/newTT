import { useEffect, useState } from "react";
import api from "./api/api";
import "./styles/timetable.css";

const DAYS = ["MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY"];

const TIME_SLOTS = [
  { label: "8:00 - 9:00", key: "08:00" },
  { label: "9:00 - 10:00", key: "09:00" },
  { label: "10:00 - 10:15", break: "SHORT" },
  { label: "10:15 - 11:15", key: "10:15" },
  { label: "11:15 - 12:15", key: "11:15" },
  { label: "12:15 - 1:15", break: "LUNCH" },
  { label: "1:15 - 2:15", key: "13:15" },
  { label: "2:15 - 3:15", key: "14:15" },
  { label: "3:15 - 4:15", key: "15:15" },
  { label: "4:15 - 5:15", key: "16:15" },
];

export default function AdminPanel() {

  const [semesters, setSemesters] = useState([]);
  const [divisions, setDivisions] = useState([]);

  const [semesterId, setSemesterId] = useState("");
  const [divisionId, setDivisionId] = useState("");

  const [timetable, setTimetable] = useState([]);

  /** ---------------- ADD CLASS UI STATE ---------------- */
  const [subjects,setSubjects] = useState([]);
  const [teachers,setTeachers] = useState([]);
  const [rooms,setRooms] = useState([]);
  const [slots,setSlots] = useState([]);

  const [form,setForm] = useState({
    subjectId:"",
    teacherSubjectAllocationId:"",
    roomId:"",
    timeSlotId:"",
    sessionType:"LEC"
  });

  /** LOAD SEMESTERS */
  useEffect(() => {
    api.get("/divisions/semesters")
      .then(res => setSemesters(res.data))
      .catch(() => alert("Failed to load semesters"));
  }, []);

  /** LOAD DIVISIONS */
  const loadDivisions = async (semId) => {
    try {
      setDivisionId("");
      const res = await api.get(`/divisions/divisions/${semId}`);
      setDivisions(res.data);
    } catch {
      alert("Failed to load divisions");
    }
  };

  /** LOAD TIMETABLE */
  const loadTimetable = async () => {
    if (!divisionId) return alert("Select division");

    try {
      const res = await api.get(`/timetable`, { params: { divisionId }});
      setTimetable(res.data);

      if(res.data.length === 0)
        alert("No timetable found");

    } catch {
      alert("Failed to load timetable");
    }
  };

  /** DELETE CLASS */
  const deleteClass = async (id) => {
    if (!id) return alert("Missing ID");
    if (!window.confirm("Delete this class?")) return;

    try {
      await api.delete(`/timetable/delete/${id}`);
      alert("Deleted");
      loadTimetable();
    } catch {
      alert("Delete failed");
    }
  };

  /** LOAD ADD PANEL LIST DROPDOWNS */
  const loadAddPanelData = async () => {
    if(!divisionId){
      alert("Select division first");
      return;
    }

    try{
      const s1 = await api.get(`/admin/subjects/${divisionId}`);
      const s2 = await api.get(`/admin/teachers/${divisionId}`);
      const s3 = await api.get(`/admin/rooms/${divisionId}`);
      const s4 = await api.get(`/admin/timeslots/${divisionId}`);

      setSubjects(s1.data);
      setTeachers(s2.data);
      setRooms(s3.data);
      setSlots(s4.data);

      alert("Add panel loaded ✔");

    }catch(e){
      alert("Backend list APIs missing (we will build next)");
    }
  };

  /** ADD CLASS */
  const addClass = async () => {
    if(
      !divisionId ||
      !form.subjectId ||
      !form.teacherSubjectAllocationId ||
      !form.roomId ||
      !form.timeSlotId
    ){
      alert("Fill all fields");
      return;
    }

    try{
      await api.post("/timetable/add",{
        divisionId,
        subjectId: form.subjectId,
        teacherSubjectAllocationId: form.teacherSubjectAllocationId,
        roomId: form.roomId,
        timeSlotId: form.timeSlotId,
        sessionType: form.sessionType
      });

      alert("Class Added Successfully 🎉");
      loadTimetable();

    }catch(e){
      alert("Failed to add class");
    }
  };

  /** GROUP DATA FOR TABLE */
  const grouped = {};
  timetable.forEach(c => {
    const time = c.startTime.substring(0,5);
    const key = `${c.dayOfWeek}-${time}`;
    if (!grouped[key]) grouped[key] = [];
    grouped[key].push(c);
  });

  return (
    <div style={{ padding:"20px" }}>
      <h2>Admin Panel</h2>

      {/* ========== FILTERS ========== */}
      <select
        value={semesterId}
        onChange={(e)=>{
          setSemesterId(e.target.value);
          loadDivisions(e.target.value);
        }}
      >
        <option value="">Select Semester</option>
        {semesters.map(s => (
          <option key={s.id} value={s.id}>
            Semester {s.number ?? s.id}
          </option>
        ))}
      </select>

      <select
        value={divisionId}
        onChange={(e)=>setDivisionId(Number(e.target.value))}
        style={{marginLeft:10}}
      >
        <option value="">Select Division</option>
        {divisions.map(d => (
          <option key={d.id} value={d.id}>{d.name}</option>
        ))}
      </select>

      <button style={{marginLeft:10}} onClick={loadTimetable}>
        Load Timetable
      </button>

      <hr/>

      {/* ================= ADD CLASS PANEL ================= */}
      <h3>Add New Class</h3>

      <button onClick={loadAddPanelData}>
        Load Add Panel Data
      </button>

      <div style={{marginTop:"10px"}}>
        <select value={form.subjectId}
          onChange={e=>setForm({...form,subjectId:e.target.value})}>
          <option value="">Select Subject</option>
          {subjects.map(s=>(
            <option key={s.id} value={s.id}>{s.name}</option>
          ))}
        </select>

        <select style={{marginLeft:10}}
          value={form.teacherSubjectAllocationId}
          onChange={e=>setForm({...form,teacherSubjectAllocationId:e.target.value})}>
          <option value="">Select Teacher</option>
          {teachers.map(t=>(
            <option key={t.id} value={t.id}>{t.teacherCode}</option>
          ))}
        </select>

        <select style={{marginLeft:10}}
          value={form.roomId}
          onChange={e=>setForm({...form,roomId:e.target.value})}>
          <option value="">Select Room</option>
          {rooms.map(r=>(
            <option key={r.id} value={r.id}>{r.roomNumber}</option>
          ))}
        </select>

        <select style={{marginLeft:10}}
          value={form.timeSlotId}
          onChange={e=>setForm({...form,timeSlotId:e.target.value})}>
          <option value="">Select Slot</option>
          {slots.map(s=>(
            <option key={s.id} value={s.id}>
              {s.dayOfWeek} {s.startTime} - {s.endTime}
            </option>
          ))}
        </select>

        <select style={{marginLeft:10}}
          value={form.sessionType}
          onChange={e=>setForm({...form,sessionType:e.target.value})}>
          <option value="LEC">Lecture</option>
          <option value="LAB">Lab</option>
          <option value="TUT">Tutorial</option>
        </select>

        <button style={{marginLeft:10}} onClick={addClass}>
          Add Class
        </button>
      </div>

      <hr/>

      {/* ================== TIMETABLE UI (with DELETE) ================== */}
      <table className="timetable">
        <thead>
          <tr>
            <th>Day</th>
            {TIME_SLOTS.map(s => (
              <th key={s.label}>{s.label}</th>
            ))}
          </tr>
        </thead>

        <tbody>
          {DAYS.map((day, dIndex) => {
            let skip = 0;

            return (
              <tr key={day}>
                <td className="day">{day}</td>

                {TIME_SLOTS.map((slot, i) => {
                  if (skip > 0) { skip--; return null; }

                  if (slot.break === "SHORT")
                    return <td key={i} className="break">BREAK</td>;

                  if (slot.break === "LUNCH")
                    return <td key={i} className="break lunch">LUNCH</td>;

                  const key = `${dIndex + 1}-${slot.key}`;
                  const entries = grouped[key];

                  if (!entries)
                    return <td key={i} className="free">—</td>;

                  const first = entries[0];

                  const isElective = first.divisionId === null;
                  const isLab = first.sessionType === "LAB" && !isElective;
                  const isTut = first.sessionType === "TUT";

                  if (isLab) skip = 1;

                  return (
                    <td
                      key={i}
                      colSpan={isLab ? 2 : 1}
                      className={`${isLab ? "lab" : ""} ${isElective ? "elective" : ""}`}
                    >

                      {/* LECTURE */}
                      {!isLab && !isTut && (
                        <>
                          <div className="subject">
                            {first.subjectName}

                            <button
                              style={{marginLeft:10,background:"red",color:"white",
                                border:"none",padding:"3px 6px",cursor:"pointer"}}
                              onClick={() => deleteClass(first.scheduledClassId)}
                            >
                              ❌
                            </button>
                          </div>

                          <div className="teacher">{first.teacherCode}</div>
                          <div className="room">{first.roomNumber}</div>
                        </>
                      )}

                      {/* TUTORIAL */}
                      {isTut && (
                        <>
                          <div className="subject">
                            {first.subjectName}
                            <button
                              style={{marginLeft:10,background:"red",color:"white",
                                border:"none",padding:"3px 6px",cursor:"pointer"}}
                              onClick={() => deleteClass(first.scheduledClassId)}
                            >
                              ❌
                            </button>
                          </div>

                          {entries.map((e, idx) => (
                            <div key={idx} className="lab-row">
                              <b>{e.batchName}</b> {e.teacherCode} – {e.roomNumber}
                            </div>
                          ))}
                        </>
                      )}

                      {/* LAB */}
                      {isLab && (
                        <div className="lab-details">
                          <button
                            style={{
                              float:"right",
                              background:"red",
                              color:"white",
                              border:"none",
                              padding:"3px 6px",
                              cursor:"pointer"
                            }}
                            onClick={() => deleteClass(first.scheduledClassId)}
                          >
                            ❌
                          </button>

                          {entries.map((e, idx) => (
                            <div key={idx} className="lab-row">
                              <b>{e.batchName}</b> :
                              {e.subjectName} – {e.teacherCode} – {e.roomNumber}
                            </div>
                          ))}
                        </div>
                      )}

                    </td>
                  );
                })}
              </tr>
            );
          })}
        </tbody>
      </table>
    </div>
  );
}
