const express = require("express");
const menu = require("../controllers/menu.controller");

const router = express.Router();

router.route("/QLTD")
    .get(menu.getAll)
    .post(menu.addDish)
    .put(menu.updateQuantity)
router.route("/Menu/:loai")
    .get(menu.getMenu)
router.route("/QLTD/:id")
    .delete(menu.delete)
    .put(menu.update)
    .patch(menu.updateState)


module.exports = router;