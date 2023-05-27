import createApiClient from "./api.service";

class UserService{
    constructor(baseUrl = "/api/users"){
        this.api = createApiClient(baseUrl);
    }
    async login(data){
        return (await this.api.post("/login", data)).data;
    }
    async getAll(){
        return (await this.api.get("/QLNV")).data;
    }
    async delete(id){
        return (await this.api.delete(`/QLNV/${id}`)).data;
    }
    async addUser(data){
        return (await this.api.post(`/QLNV/`, data)).data;
    }
    async update(id, data){
        return (await this.api.put(`/QLNV/${id}`, data)).data;
    }
    async updateAvar(formData, id){
        return (await this.api.put(`/Profile/${id}`, formData,
        {
            headers: {
                'Content-Type': 'multipart/form-data'
            }
        })).data;
    }
    async getUser(id){
        return (await this.api.get(`/Profile/${id}`)).data;
    }
    async updatePassword(id, password){
        return (await this.api.put(`/Profile/Password/${id}`, password)).data;
    }
    async updateProfile(data){
        return (await this.api.post(`/Profile/${data._id}`, data)).data;
    }

}

export default new UserService();