const { log } = require("console");
const { ObjectId } = require("mongodb");

class SaleService {
    constructor(client) {
        this.Sale = client.db().collection("sale");
    }

    async getAll() {
        const result = await this.Sale.find({})
        return await result.toArray();
    }
    async delete(id) {
        const result = await this.Sale.findOneAndDelete({ _id: id })
        return result.ok;
    }
    async update(id, payload) {
        console.log(id, payload);
        const result = await this.Sale.findOneAndUpdate(
            { _id: id },
            {
                $set: {
                    ten_khuyen_mai: payload.ten_khuyen_mai,
                    chi_tiet_khuyen_mai: payload.chi_tiet_khuyen_mai,
                    gia_tri: Number(payload.gia_tri),
                    rang_buoc: Number(payload.rang_buoc)
                }
            }
        )
        console.log(result);
        return result;
    }
    async add(payload) {
        const result = await this.Sale.insertOne({
            _id: payload.mkm,
            ten_khuyen_mai: payload.ten_khuyen_mai,
            chi_tiet_khuyen_mai: payload.chi_tiet_khuyen_mai,
            gia_tri: Number(payload.gia_tri),
            rang_buoc: Number(payload.rang_buoc)
        })
        return result;
    }
}

module.exports = SaleService;