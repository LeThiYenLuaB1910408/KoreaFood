const express = require("express");
const bill = require("../controllers/bill.controller");

const router = express.Router();

router.route("/LSHD")
    .get(bill.getAll)


module.exports = router;