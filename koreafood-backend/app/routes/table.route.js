const express = require("express");
const table = require("../controllers/table.controller");

const router = express.Router();

router.route("/QLBA")
    .get(table.getTable)
    .post(table.addTable)
router.route(`/QLBA/:id`)
    .delete(table.delete);


module.exports = router;