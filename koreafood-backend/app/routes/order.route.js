const express = require("express");
const order = require("../controllers/order.controller");

const router = express.Router();

router.route("/sendorder")
    .post(order.createOrder)
router.route("/updateorder")
    .put(order.updateOrder)
    .post(order.updateState)
router.route("/getOrder/:id")
    .get(order.getOrder)
    .put(order.successOrder)
router.route("/getOrder")
    .get(order.getAll)
router.route("/deleteorder/:id")
    .delete(order.deleteOrder)


module.exports = router;