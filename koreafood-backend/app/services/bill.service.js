const { log } = require("console");
const { ObjectId } = require("mongodb");

class BillService {
    constructor(client) {
        this.Bill = client.db().collection("bill");
    }

    async getAll() {
        const result = await this.Bill.find({})
        return await result.toArray();
    }
}

module.exports = BillService;