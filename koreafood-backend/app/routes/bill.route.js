const express = require("express");
const bill = require("../controllers/bill.controller");

const router = express.Router();

router.route("/LSHD")
    .get(bill.getAll)
    .post(bill.getBillDay)
router.route("/LSHD/:id")
    .get(bill.getBill)
    .put(bill.updateState)
router.route("/HoaDon/:so_ban")
    .get(bill.getTableBill)
router.route("/payment")
.post(bill.payment)


module.exports = router;