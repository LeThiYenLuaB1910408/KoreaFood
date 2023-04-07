const OrderService = require("../services/order.service");
const MongoDB = require("../utils/mongodb.util");

exports.getOrder = async (req, res, next) => {
    try {
        const orderService = new OrderService(MongoDB.client);
        const document = await orderService.getOrder(req.params.id);
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Lấy Thực Đơn!!!`);
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
        return console.log(`Có Lỗi Trong Lúc Tạo Đơn Hàng!!!`);
    }
};