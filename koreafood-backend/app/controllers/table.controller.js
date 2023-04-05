const TableService = require("../services/table.service");
const MongoDB = require("../utils/mongodb.util");

exports.getTable = async (req, res, next) => {
    try {
        const tableService = new TableService(MongoDB.client);
        const document = await tableService.getTable();
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Lấy Bàn Ăn!!!`);
    }
};
exports.delete = async (req, res, next) => {
    try {
        const tableService = new TableService(MongoDB.client);
        const document = await tableService.delete(req.params.id);
        if (document == 1) {
            return res.send({ message: `Xóa Thành Công!!!` })
        }
        return res.send(document);
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Xóa Bàn Ăn!!!`);
    }
};
exports.addTable = async (req, res, next) => {
    try {
        const tableService = new TableService(MongoDB.client);
        await tableService.addTable(req.body);
        return res.send({message: "Thêm Bàn Thành Công!!!"});
    } catch (error) {
        return console.log(`Có Lỗi Trong Lúc Thêm Bàn Ăn!!!`);
    }
};