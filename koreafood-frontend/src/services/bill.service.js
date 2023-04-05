import createApiClient from "./api.service";

class BillService{
    constructor(baseUrl = "/api/bill"){
        this.api = createApiClient(baseUrl);
    }
    async getAll(){
        return (await this.api.get("/LSHD")).data;
    }
}

export default new BillService(); 