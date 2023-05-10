const { log } = require("console");
const { ObjectId } = require("mongodb");

class BillService {
    constructor(client) {
        this.Bill = client.db().collection("bill");
        this.Order = client.db().collection("orderform");
    }

    async getAll() {
        const result = await this.Bill.find({})
        return await result.toArray();
    }
    async getBillDay(payload) {
        let result = await this.Bill.find({})
        result = await result.toArray();
        result = result.filter(e=>e.thoi_gian.split(' ')[1] == payload.date.split(' ')[1]);
        return result;
    }
    async getBill(id) {
        const result = await this.Bill.find({ ma_nhan_vien_xuat_don: id })
        return await result.toArray();
    }
    async getTableBill(so_ban) {
        const result = await this.Bill.findOne({ so_ban: Number(so_ban),  trang_thai_hoa_don:'Tạm tính'})
        return result;
    }
    async payment(payload) {
        const allBill = await (await this.Bill.find({})).toArray();

        const order = await this.Order.findOne({ so_ban: payload.so_ban })

        const result = await this.Bill.insertOne({
            _id: `HD${allBill.length + 1}`,
            thoi_gian: new Date().toLocaleString('vi-VN', { timeZone: 'Asia/Ho_Chi_Minh' }),
            ma_nhan_vien_lap_don: order.ma_nhan_vien_lap_don,
            danh_sach_mon_an: payload.danh_sach_mon_an,
            tong_so_luong: payload.so_luong,
            khuyen_mai_ap_dung: payload.khuyen_mai_ap_dung,
            gia_tri_giam_gia: payload.gia_tri_giam_gia,
            tong_tien: payload.tong_tien,
            so_ban: Number(payload.so_ban),
            phuong_thuc_thanh_toan: payload.phuong_thuc_thanh_toan,
            ma_nhan_vien_xuat_don: payload.ma_nhan_vien_xuat_don,
            trang_thai_hoa_don: 'Tạm tính'
        })

        

        return { "so_hoa_don": allBill.length + 1 };
    }
    async updateState(id, payload) {
        const rs = await this.Bill.findOneAndUpdate({ _id: id },
            {
                $set: {
                    trang_thai_hoa_don: payload.trang_thai_hoa_don
                }
            }
        )
        await this.Order.findOneAndDelete({ so_ban: `${payload.so_ban}` });
        return rs;
    }
}

module.exports = BillService;