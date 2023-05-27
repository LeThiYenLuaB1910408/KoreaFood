const { ObjectId } = require("mongodb");

class TableService {
    constructor(client) {
        this.Table = client.db().collection("table");
    }

    async getTable() {
        const result = await this.Table.find({})
        return await result.toArray();
    }
    async delete(id) {
        const result = await this.Table.findOneAndDelete({ _id: id })
        return result.ok;
    }
    async update(id, payload) {
        const result = await this.Table.findOneAndUpdate({ _id: id },
            {
                $set: {
                    'trang_thai_ban_an': payload.trang_thai_ban_an
                }
            }
        )
        return result.ok;
    }
    async addTable(data) {
        await this.Table.insertOne({ _id: data.so_ban, so_cho_ngoi: Number(data.so_cho_ngoi), trang_thai_ban_an: "Trống" })
    }
}

module.exports = TableService;