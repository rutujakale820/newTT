import { useEffect, useState } from "react";
import api from "../api/api";
import "../styles/timetable.css";

const DAYS = ["MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY"];

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

export default function StudentTimetable({
  divisionId,
  semesterId,
  divisionName,
}) {
  const [data, setData] = useState([]);

  useEffect(() => {
    if (!divisionId) return;
    api
      .get(`/student/timetable?divisionId=${divisionId}`)
      .then((res) => setData(res.data))
      .catch(() => setData([]));
  }, [divisionId]);

  const grouped = {};
  data.forEach((c) => {
    const time = c.startTime.substring(0, 5);
    const key = `${c.dayOfWeek}-${time}`;
    if (!grouped[key]) grouped[key] = [];
    grouped[key].push(c);
  });

  return (
    <div className="timetable-page">
  <div className="timetable-heading">
  <h3>
    Semester {semesterId} – Division {divisionName}
  </h3>
  
</div>

      <table className="timetable">
        <thead>
          <tr>
            <th>Day</th>
            {TIME_SLOTS.map((s) => (
              <th key={s.label}>{s.label}</th>
            ))}
          </tr>
        </thead>

        <tbody>
          {DAYS.map((day, dIndex) => (
            <tr key={day}>
              <td className="day">{day}</td>

              {TIME_SLOTS.map((slot, i) => {
                if (slot.break === "SHORT")
                  return <td key={i} className="break">BREAK</td>;

                if (slot.break === "LUNCH")
                  return <td key={i} className="lunch">LUNCH</td>;

                const key = `${dIndex + 1}-${slot.key}`;
                const entries = grouped[key];

                if (!entries)
                  return <td key={i} className="free">—</td>;

                const first = entries[0];

                return (
                  <td key={i} className="cell">
                    <div className="subject">{first.subjectName}</div>
                    <div className="teacher">{first.teacherCode}</div>
                    <div className="room">{first.roomNumber}</div>
                  </td>
                );
              })}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
