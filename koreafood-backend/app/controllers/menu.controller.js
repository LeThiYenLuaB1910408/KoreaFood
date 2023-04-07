const MenuService = require("../services/menu.service");
const MongoDB = require("../utils/mongodb.util");

exports.getAll = async (req, res, next) => {
    try {
        const menuService = new MenuService(MongoDB.client);
        const document = await menuService.getAll();
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Lấy Thực Đơn!!!`);
    }
};
exports.getMenu = async (req, res, next) => {
    try {
        const menuService = new MenuService(MongoDB.client);
        const document = await menuService.getMenu(req.params.loai);
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Lấy Thực Đơn!!!`);
    }
};
exports.addDish = async (req, res, next) => {
    try {
        const menuService = new MenuService(MongoDB.client);
        const document = await menuService.addDish(req.files.file, req.body);
        if (document == true) {
            return res.send({ message: `Thêm Món Ăn Thành Công!!!` });
        }
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Thêm Thực Đơn!!!`);
    }
};
exports.updateQuantity = async (req, res, next) => {
    try {
        const menuService = new MenuService(MongoDB.client);
        const document = await menuService.updateQuantity(req.body);
        if (document == true) {
            return res.send({ message: `Cập Nhật Món Ăn Thành Công!!!` });
        }
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Cập Nhật Thực Đơn!!!`);
    }
};
exports.update = async (req, res, next) => {
    try {
        const menuService = new MenuService(MongoDB.client);
        const document = await menuService.update(req.params.id, req.files, req.body);
        if (document == 1) {
            return res.send({ message: `Cập Nhật Món Ăn Thành Công!!!` });
        }
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Cập Nhật Thực Đơn!!!`);
    }
};
exports.delete = async (req, res, next) => {
    try {
        const menuService = new MenuService(MongoDB.client);
        const document = await menuService.delete(req.params.id);
        if (document == 1) {
            return res.send({ message: `Xóa Thành Công!!!` })
        }
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Xóa Thực Đơn!!!`);
    }
};