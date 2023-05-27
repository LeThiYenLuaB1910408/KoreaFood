const express = require("express");
const users = require("../controllers/user.controller");

const router = express.Router();

router.route("/login")
    .post(users.login);
router.route("/QLNV")
    .get(users.getAll)
    .post(users.addUser)
router.route("/QLNV/:id")
    .delete(users.delete)
    .put(users.update)
router.route("/Profile/:id")
    .put(users.updateAvar)
    .get(users.getUser)
    .post(users.updateProfile)
router.route("/Profile/Password/:id")
    .put(users.updatePassword)

module.exports = router;