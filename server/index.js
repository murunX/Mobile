const express = require("express");
const http = require("http");
const mongoose = require("mongoose");

const app = express();
const port = process.env.PORT || 3000;
const server = http.createServer(app);
const io = require("socket.io")(server);
const Room = require("./models/room");

app.use(express.json());

const DB = "mongodb+srv://murun:Ih80946194@cluster0.rvrsj4q.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

io.on("connection", (socket) => {
  console.log("connected!");

  socket.on("createRoom", async ({ nickname }) => {
    console.log(nickname);
    try {
      let room = new Room();
      let player = {
        socketID: socket.id,
        nickname
      };
      room.players.push(player);
      room = await room.save();
      const roomId = room._id.toString();

      socket.join(roomId);
      io.to(roomId).emit("createRoomSuccess", room);
    } catch (e) {
      console.log(e);
    }
  });

  socket.on("joinRoom", async ({ nickname, roomId }) => {
    try {
      if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit("errorOccurred", "Please enter a valid room ID.");
        return;
      }
      let room = await Room.findById(roomId);

      if (room.isJoin) {
        let player = {
          nickname,
          socketID: socket.id
        };
        socket.join(roomId);
        room.players.push(player);
        room.isJoin = false;
        room = await room.save();
        io.to(roomId).emit("joinRoomSuccess", room);
        io.to(roomId).emit("updatePlayers", room.players);
        io.to(roomId).emit("updateRoom", room);
      } else {
        socket.emit(
          "errorOccurred",
          "The game is in progress, try again later."
        );
      }
    } catch (e) {
      console.log(e);
    }
  });

// Server-side code
socket.on("exitRoom", async ({ roomId, nickname }) => {
  try {
    let room = await Room.findById(roomId);
    
    // Find the index of the player to remove
    const playerIndex = room.players.findIndex(player => player.nickname === nickname);
    if (playerIndex !== -1) {
      // Remove the player from the room
      room.players.splice(playerIndex, 1);
      await room.save();
      
      // Notify other players in the room about the player exit
      io.to(roomId).emit("exitRoomSuccess", room.players);
      io.to(roomId).emit("updateRoom", room);
      console.log("garsan bn",room.players)
    }
  } catch (e) {
    console.log(e);
  }
});


  socket.on("makeChoices", async ({ choice, roomId }) => {
    try {
        let room = await Room.findById(roomId);
        
        // Find the player making the choice
        let player = room.players.find(player => player.socketID === socket.id);
        console.log("ROMMSHU", player.socketID);
        console.log("Rchoice", player.playerChoice);
        
        // Update the player's choice
        if (player) {
            player.playerChoice = choice;
            console.log("ROMMSHU", player.nickname);
            console.log("servr", player.playerChoice);
            await room.save();
            
            // Check if both players have made their choices
            if (room.players.every(player => player.playerChoice)) {
                // Determine the winner
                let player1Choice = room.players[0].playerChoice;
                let player2Choice = room.players[1].playerChoice;
                console.log("0shu", room.players[0].playerChoice);
                console.log("1shu", room.players[1].playerChoice);
                let winner = determineWinner(player1Choice, player2Choice);

                // Emit the result to both players
                io.to(roomId).emit("gameResult", { winner, room });

                // Reset player choices for the next round
                room.players.forEach(player => {
                    player.playerChoice = null;
                });
                await room.save();
                
                // Emit the updated player choices and room data to the frontend
                io.to(roomId).emit("makeChoice", {
                    player1Choice,
                    player2Choice,
                    room,
                });
            }
        } else {
            console.log("Player not found");
        }
    } catch (e) {
        console.log(e);
    }
});

  

// Socket.io connection handling
io.on('connection', (socket) => {
  console.log('New client connected');
  
  // Handle the makeChoice event
  socket.on('makeChoice', (data) => {
    console.log('Received makeChoice event');
    console.log('Data:', data);
    console.log('SOCKEDOT:', socket.id);

  });

  // Other event handlers...
});


  function determineWinner(player1Choice, player2Choice) {
    
    if (player1Choice === player2Choice) {
      console.log("tentsev");
        return null; // It's a draw
    } else if (
        (player1Choice === 'Rock' && player2Choice === 'Scissor') ||
        (player1Choice === 'Scissor' && player2Choice === 'Paper') ||
        (player1Choice === 'Paper' && player2Choice === 'Rock')
    ) {
      console.log("player1");
        return 'player1'; // Player 1 wins
  
    } else {
      console.log("player2");
        return 'player2'; // Player 2 wins
    }
}
  socket.on("winner", async ({ winnerSocketId, roomId }) => {
    try {
      let room = await Room.findById(roomId);
      let player = room.players.find(
        (playerr) => playerr.socketID == winnerSocketId
      );
      player.points += 1;
      console.log(player.points);
      room = await room.save();
       
      if (player.points >= room.maxRounds) {
        io.to(roomId).emit("endGame", player);
      } else {
        io.to(roomId).emit("pointIncrease", player);
      }
    } catch (e) {
      console.log(e);
    }
  });
});

mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection successful!");
  })
  .catch((e) => {
    console.log(e);
  });

server.listen(port, "0.0.0.0", () => {
  console.log(`Server started and running on port ${port}`);
});
