import createApiClient from "./api.service";

class SaleService{
    constructor(baseUrl = "/api/sale"){
        this.api = createApiClient(baseUrl);
    }
    async getAll(){
        return (await this.api.get("/QLKM")).data;
    }
    async delete(id){
        return (await this.api.delete(`/QLKM/${id}`)).data;
    }
    
    async update(id,data) {
        return (await this.api.put(`/QLKM/${id}`, data)).data;
    }
    async add(data) {
        return (await this.api.post('/QLKM', data)).data;
    }
}

export default new SaleService(); 