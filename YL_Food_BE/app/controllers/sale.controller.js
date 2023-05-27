const SaleService = require("../services/sale.service");
const MongoDB = require("../utils/mongodb.util");

exports.getAll = async (req, res, next) => {
    try {
        const saleService = new SaleService(MongoDB.client);
        const document = await saleService.getAll();
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Lấy Khuyến Mãi!!!`);
    }
};
exports.add = async (req, res, next) => {
    try {
        const saleService = new SaleService(MongoDB.client);
        const document = await saleService.add(req.body);
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Thêm Khuyến Mãi!!!`);
    }
};
exports.update = async (req, res, next) => {
    try {
        const saleService = new SaleService(MongoDB.client);
        const document = await saleService.update(req.params.id, req.body);
        if (document == 1) {
            return res.send({ message: `Cập Nhật Khuyến Mãi Thành Công!!!` });
        }
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Cập Nhật Khuyến Mãi!!!`);
    }
};
exports.delete = async (req, res, next) => {
    try {
        const saleService = new SaleService(MongoDB.client);
        const document = await saleService.delete(req.params.id);
        if (document == 1) {
            return res.send({ message: `Xóa Thành Công!!!` })
        }
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Xóa Khuyến Mãi!!!`);
    }
};