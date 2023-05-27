const express = require("express");
const sale = require("../controllers/sale.controller");

const router = express.Router();

router.route("/QLKM")
    .get(sale.getAll)
    .post(sale.add)
router.route(`/QLKM/:id`)
    .delete(sale.delete)
    .put(sale.update)


module.exports = router;