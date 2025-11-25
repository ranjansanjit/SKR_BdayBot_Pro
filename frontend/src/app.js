import React, { useState } from "react";
import { sendWish } from "./api";

export default function App() {
  const [name, setName] = useState("");
  const [wish, setWish] = useState("");

  const handleSendWish = async () => {
    if (!name) return alert("Please enter a name");
    try {
      const data = await sendWish(name);
      setWish(data.message);
    } catch {
      alert("Backend not running or error occurred.");
    }
  };

  return (
    <div>
      <input value={name} onChange={(e) => setName(e.target.value)} placeholder="Enter name" />
      <button onClick={handleSendWish}>Send Wish</button>
      {wish && <p>{wish}</p>}
    </div>
  );
}
