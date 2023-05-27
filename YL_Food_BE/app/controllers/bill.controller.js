const BillService = require("../services/bill.service");
const MongoDB = require("../utils/mongodb.util");

exports.getAll = async (req, res, next) => {
    try {
        const billService = new BillService(MongoDB.client);
        const document = await billService.getAll();
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Lấy Hóa Đơn!!!`);
    }
};
exports.getBillDay = async (req, res, next) => {
    try {
        const billService = new BillService(MongoDB.client);
        const document = await billService.getBillDay(req.body);
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Lấy Hóa Đơn!!!`);
    }
};
exports.getBill = async (req, res, next) => {
    try {
        const billService = new BillService(MongoDB.client);
        const document = await billService.getBill(req.params.id);
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Lấy Hóa Đơn!!!`);
    }
};
exports.getTableBill = async (req, res, next) => {
    try {
        const billService = new BillService(MongoDB.client);
        const document = await billService.getTableBill(req.params.so_ban);
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Lấy Hóa Đơn!!!`);
    }
};
exports.payment = async (req, res, next) => {
    try {
        const billService = new BillService(MongoDB.client);
        const document = await billService.payment(req.body);
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Thêm Hóa Đơn!!!`);
    }
};
exports.updateState = async (req, res, next) => {
    try {
        const billService = new BillService(MongoDB.client);
        const document = await billService.updateState(req.params.id, req.body);
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Cập Nhật Hóa Đơn!!!`);
    }
};