const OrderService = require("../services/order.service");
const MongoDB = require("../utils/mongodb.util");
const io = require('../../server');

exports.getOrder = async (req, res, next) => {
    try {
        const orderService = new OrderService(MongoDB.client);
        const document = await orderService.getOrder(req.params.id);
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Lấy Thực Đơn!!!`);
    }
};

exports.successOrder = async (req, res, next) => {
    try {
        const orderService = new OrderService(MongoDB.client);
        const document = await orderService.successOrder(req.params.id,req.body);
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Cập Nhật Thực Đơn!!!`);
    }
};

exports.getAll = async (req, res, next) => {
    try {
        const orderService = new OrderService(MongoDB.client);
        const document = await orderService.getAll();
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Lấy Tất Cả Thực Đơn!!!`);
    }
};
exports.createOrder = async (req, res, next) => {
    try {
        const orderService = new OrderService(MongoDB.client);
        const document = await orderService.createOrder(req.body);
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Tạo Đơn Hàng!!!`);
    }
};
exports.updateOrder = async (req, res, next) => {
    try {
        const orderService = new OrderService(MongoDB.client);
        const document = await orderService.updateOrder(req.body);
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Cập Nhật Đơn Hàng!!!`);
    }
};
exports.updateState = async (req, res, next) => {
    try {
        const orderService = new OrderService(MongoDB.client);
        const document = await orderService.updateState(req.body);
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Cập Nhật Đơn Hàng!!!`);
    }
};
exports.deleteOrder = async (req, res, next) => {
    try {
        const orderService = new OrderService(MongoDB.client);
        const document = await orderService.deleteOrder(req.params.id);
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Hủy Đơn Hàng!!!`);
    }
};