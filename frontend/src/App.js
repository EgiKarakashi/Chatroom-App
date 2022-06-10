import './App.css';
import {useEffect, useState} from 'react';
import axios from 'axios';

function App() {
  const [rooms, setRooms] = useState([]);

  useEffect(() => {
    axios
      .get(
        "https://8080-egikarakash-gitpodworks-9efplgr5so9.ws-eu47.gitpod.io/api/rest/get-chatrooms-details"
      )
      .then((res) => {
        console.log(res.data.Rooms);
        setRooms(res.data.Rooms);
      });
  }, []);
  
  return (
    
    <div className="App">
      <center>
      <h1>Chatroom Details</h1>
      <thead>
        <tr>
          <th style={{ border: "3px solid black" }}>Rooms</th>
          <th style={{ border: "3px solid black" }}>Createc By</th>
        </tr>
      </thead>
      <tbody>
        {rooms.map((room) => (
          <tr key={room.Room_ID}>
            <td style={{ border: "2px solid black" }}>
              Room ID: {room.Room_ID}
            </td>
            <td style={{ border: "2px solid black" }}>
              Created By user with ID: {room.Create_By}
            </td>
          </tr>
        ))}
      </tbody>
      </center>
    </div>
    
  );
}

export default App;
