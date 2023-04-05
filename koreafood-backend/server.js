const app = require("./app");
const config = require("./app/config");
const MongoDB = require("./app/utils/mongodb.util");
// const http = require('http');
// const server = http.createServer(app);
// const { Server } = require("socket.io");
// const io = new Server(server);

// const express = require('express');
// const { Server } = require('ws');

// const PORT = process.env.PORT || 4000; //port for https

// const server = express()
//     .use((req, res) => res.send("Hi there"))
//     .listen(PORT, () => console.log(`Listening on ${PORT}`));

// const wss = new Server({ server });

// wss.on('connection', function (ws, req) {
//     console.log('a user connected');
//     ws.on('message', message => {
//         var dataString = message.toString();
//         if (dataString == "Hello") {
//             console.log(dataString)
//             ws.send("Hi from Node.js");
//             setTimeout(()=>{},500)
//         } else{
//             console.log(dataString)
//             ws.send("Are you not saying hi to me 🥺👉👈");
//         }
//     }) 
// })

// const TableService = require("./app/services/table.service");

async function startServer() {
    try {
        await MongoDB.connect(config.db.uri);
        console.log("Connected to the db");

        const PORT = config.app.port;
        app.listen(PORT, () => {
            console.log(`Server is running on port ${PORT}`);
        });
        // const tableService = new TableService(MongoDB.client);
        // io.on('connection', (client) => {
        //     console.log('a user connected');
        //     client.on("getTable",async (data)=>{
        //           const rs = await tableService.getTable();
        //         io.emit("getTable",JSON.stringify(rs));
        //     })
        //   });

    } catch (error) {
        console.log('Cannot connect to the db', error);
        process.exit();
    }
}

startServer();