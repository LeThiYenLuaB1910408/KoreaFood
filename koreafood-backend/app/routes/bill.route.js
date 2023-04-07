const express = require("express");
const bill = require("../controllers/bill.controller");

const router = express.Router();

router.route("/LSHD")
    .get(bill.getAll)
router.route("/LSHD/:id")
    .get(bill.getBill)
router.route("/payment")
.post(bill.payment)


module.exports = router;