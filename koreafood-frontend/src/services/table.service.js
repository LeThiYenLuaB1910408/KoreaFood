import createApiClient from "./api.service";

class TableService{
    constructor(baseUrl = "/api/table"){
        this.api = createApiClient(baseUrl);
    }
    async getTable(){
        return (await this.api.get("/QLBA")).data;
    }
    async delete(id){
        return (await this.api.delete(`/QLBA/${id}`)).data;
    }
    async addTable(data){
        return (await this.api.post("/QLBA", data)).data;
    }
}

export default new TableService();