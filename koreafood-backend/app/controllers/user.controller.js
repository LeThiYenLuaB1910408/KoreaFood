const UserService = require("../services/user.service");
const MongoDB = require("../utils/mongodb.util");

exports.login = async (req, res, next) => {
    try {
        const userService = new UserService(MongoDB.client);
        const document = await userService.login(req.body);
        if (document != false) {
            return res.send(document);
        } else {
            return res.send({ message: `Lỗi` })
        }
    } catch (error) {
        return console.log(`Có Lỗi Trong Quá Trình Đăng Nhập!!!`);
    }
};
exports.getAll = async (req, res, next) => {
    try {
        const userService = new UserService(MongoDB.client);
        const document = await userService.getAll();
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Quá Trình Lấy Tài Khoản!!!`);
    }
};
exports.getUser = async (req, res, next) => {
    try {
        const userService = new UserService(MongoDB.client);
        const document = await userService.getUser(req.params.id);
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Quá Trình Lấy Người Dùng!!!`);
    }
};
exports.addUser = async (req, res, next) => {
    try {
        const userService = new UserService(MongoDB.client);
        const document = await userService.addUser(req.body);
        if (document == true) {
            return res.send({ message: `Thêm Tài Khoản Thành Công!!!` });
        }
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Quá Trình Tạo Tài Khoản!!!`);
    }
};
exports.delete = async (req, res, next) => {
    try {
        const userService = new UserService(MongoDB.client);
        const document = await userService.delete(req.params.id);
        if (document == 1) {
            return res.send({ message: "Xóa Thành Công!!!" })
        } else {
            return res.send({ message: "Xóa Không Thành Công!!!" })
        }
    } catch (error) {
        return console.log(`Có Lỗi Trong Quá Trình Xóa Tài Khoản!!!`);
    }
};
exports.update = async (req, res, next) => {
    try {
        const userService = new UserService(MongoDB.client);
        const document = await userService.update(req.params.id, req.body);
        if (document == 1) {
            return res.send({ message: "Cập Nhật Thành Công!!!" })
        } else {
            return res.send({ message: "Cập Nhật Không Thành Công!!!" })
        }
    } catch (error) {
        return console.log(`Có Lỗi Trong Quá Trình Cập Nhật Tài Khoản!!!`);
    }
};
exports.updateAvar = async (req, res, next) => {
    try {
        console.log(req.files);
        const userService = new UserService(MongoDB.client);
        const document = await userService.updateAvar(req.files.file, req.params.id);
        if (document == 1) {
            return res.send({ message: "Cập Nhật Thành Công!!!" })
        } else {
            return res.send({ message: "Cập Nhật Không Thành Công!!!" })
        }
    } catch (error) {
        return console.log(`Có Lỗi Trong Quá Trình Cập Nhật Ảnh Đại Diện!!!`);
    }
};
exports.updatePassword = async (req, res, next) => {
    try {
        const userService = new UserService(MongoDB.client);
        const document = await userService.updatePassword(req.params.id, req.body);
        if (document == 1) {
            return res.send({ message: "Cập Nhật Mật Khẩu Thành Công!!!" })
        } else {
            return res.send({ message: "Mật Khẩu Không Đúng!!!" })
        }
    } catch (error) {
        return console.log(`Có Lỗi Trong Quá Trình Cập Nhật Mật Khẩu Tài Khoản!!!`);
    }
};
exports.updateProfile = async (req, res, next) => {
    try {
        const userService = new UserService(MongoDB.client);
        const document = await userService.updateProfile(req.params.id, req.body);
        if (document == 1) {
            return res.send({ message: "Cập Nhật Thành Công!!!" })
        } else {
            return res.send({ message: "Lỗi!!!" })
        }
    } catch (error) {
        return console.log(`Có Lỗi Trong Quá Trình Cập Nhật Thông Tin Tài Khoản!!!`);
    }
};