import createApiClient from "./api.service";

class BillService{
    constructor(baseUrl = "/api/bill"){
        this.api = createApiClient(baseUrl);
    }
    async getAll(){
        return (await this.api.get("/LSHD")).data;
    }
    async getBill(so_ban){
        return (await this.api.get(`/HoaDon/${so_ban}`)).data;
    }
    async getBillDay(date){
        return (await this.api.post("/LSHD",date)).data;
    }
    async updateState(id, data){
        return (await this.api.put(`/LSHD/${id}`, data)).data;
    }
}

export default new BillService(); 