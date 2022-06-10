import './App.css';
import {useEffect, useState} from 'react';
import axios from 'axios';

function App() {
  const [rooms, setRooms] = useState([]);

  useEffect(() => {
    axios
      .get(
        "/api/rest/getchatrooms"
      )
      .then((res) => {
        console.log(res.data.rooms);
        setRooms(res.data.rooms);
      });
  }, []);
  
  return (
    
    <div className="App">
      <center>
      <h1>Chatroom Details</h1>
      <thead>
        <tr>
          <th style={{ border: "3px solid black" }}>Rooms</th>
          <th style={{ border: "3px solid black" }}>Created By</th>
        </tr>
      </thead>
      <tbody>
        {rooms.map((room) => (
          <tr key={room.rooms}>
            <td style={{ border: "2px solid blue" }}>
              Room ID: {room.rooms}
            </td>
            <td style={{ border: "2px solid blue" }}>
              Created By user with ID: {room.created_by}
            </td>
          </tr>
        ))}
      </tbody>
      </center>
    </div>
    
  );
}

export default App;
