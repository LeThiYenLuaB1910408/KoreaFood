const { log } = require("console");
const { ObjectId } = require("mongodb");

class OrderService {
    constructor(client) {
        this.Order = client.db().collection("orderform");
    }

    async getOrder(id) {
        const result = await this.Order.findOne({ so_ban: id })
        return result;
    }
    async createOrder(payload) {
        const rs = await this.Order.insertOne({
            'thoi_gian': new Date().toLocaleString('vi-VN', { timeZone: 'Asia/Ho_Chi_Minh' }),
            'danh_sach_mon_an': payload.danh_sach_mon_an,
            'tong_so_luong': payload.danh_sach_mon_an.length,
            'tong_tien': payload.tong_tien,
            'trang_thai_don': 'Đang chuẩn bị',
            'ma_nhan_vien_lap_don': payload.ma_nhan_vien_lap_don,
            'so_ban': payload.so_ban
        });
        return rs.ok;
    }
    async updateOrder(payload) {
        const rs = await this.Order.findOneAndUpdate({ so_ban: payload.so_ban }, {
            $set: {
                'thoi_gian': new Date().toLocaleString('vi-VN', { timeZone: 'Asia/Ho_Chi_Minh' }),
                'danh_sach_mon_an': payload.danh_sach_mon_an,
                'tong_so_luong': payload.danh_sach_mon_an.length,
                'tong_tien': payload.tong_tien,
            }
        });
        return rs;
    }
}

module.exports = OrderService;