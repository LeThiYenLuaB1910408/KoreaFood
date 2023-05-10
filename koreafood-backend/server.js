const { log } = require("console");
const app = require("./app");
const config = require("./app/config");
const MongoDB = require("./app/utils/mongodb.util");
const http = require('http');
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server, {
    cors: {
        origin: "http://127.0.0.1:3001"
    }
});

async function startServer() {
    try {
        await MongoDB.connect(config.db.uri);
        console.log("Connected to the db");

        const PORT = config.app.port;
        server.listen(PORT, () => {
            console.log(`Server is running on port ${PORT}`);
        });
        io.on('connection', (client) => {
            client.on("successOrder", async (data) => {
                io.emit("message", `Hoàn Thành Đơn Món Bàn Số ${data}`);
            })
            client.on("sendOrder", async (data) => {
                io.emit("sendOrderWeb", data);
            })
            client.on("updateOrder", async (data) => {
                io.emit("updateOrderWeb", data);
            })
            client.on("deleteOrder", async (data) => {
                io.emit("deleteOrderWeb", data);
            })
        });

    } catch (error) {
        console.log('Cannot connect to the db', error);
        process.exit();
    }
}

startServer();