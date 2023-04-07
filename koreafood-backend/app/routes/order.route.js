const express = require("express");
const order = require("../controllers/order.controller");

const router = express.Router();

router.route("/sendorder")
    .post(order.createOrder)
router.route("/updateorder")
    .put(order.updateOrder)
router.route("/getOrder/:id")
    .get(order.getOrder)


module.exports = router;