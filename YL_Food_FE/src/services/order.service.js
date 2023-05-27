import createApiClient from "./api.service";

class OrderService{
    constructor(baseUrl = "/api/order"){
        this.api = createApiClient(baseUrl);
    }
    async getAll(){
        return (await this.api.get("/getOrder")).data;
    }
    async updateState(data){
        return (await this.api.post("/updateorder", data)).data;
    }
    async successOrder(id,data){
        return (await this.api.put(`/getOrder/${id}`,data)).data;
    }

}

export default new OrderService(); 