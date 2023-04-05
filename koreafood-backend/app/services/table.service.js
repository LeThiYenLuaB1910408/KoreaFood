const { ObjectId } = require("mongodb");

class TableService {
    constructor(client) {
        this.Table = client.db().collection("table");
    }

    async getTable() {
        const result = await this.Table.find({})
        return await result.toArray();
    }
    async delete(id){
        const result = await this.Table.findOneAndDelete({_id: id})
        return result.ok;
    }
    async addTable(data){
       await this.Table.insertOne({_id: data.so_ban, so_cho_ngoi: data.so_cho_ngoi, trang_thai_ban_an: "Trống"}) 
    }
}

module.exports = TableService;