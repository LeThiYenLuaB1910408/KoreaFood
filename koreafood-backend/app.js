const express = require("express");
const cors = require("cors");


const userRouter = require("./app/routes/user.route");
const menuRouter = require("./app/routes/menu.route");
const tableRouter = require("./app/routes/table.route");
const saleRouter = require("./app/routes/sale.route");
const billRouter = require("./app/routes/bill.route");
const orderRouter = require("./app/routes/order.route");

const app = express();
const fileUpload = require('express-fileupload');

app.use(cors());
app.use(fileUpload());
app.use(express.json());
app.use("/api/users", userRouter);
app.use("/api/menu", menuRouter);
app.use("/api/table", tableRouter);
app.use("/api/sale", saleRouter);
app.use("/api/bill", billRouter);
app.use("/api/order", orderRouter);
app.get("/", (req, res) => { res.json({ message: "Welcome to KoreaFood App." }); });

module.exports = app;