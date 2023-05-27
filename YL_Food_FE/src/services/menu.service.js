import createApiClient from "./api.service";

class MenuService {
    constructor(baseUrl = "/api/menu") {
        this.api = createApiClient(baseUrl);
    }
    async getAll() {
        return (await this.api.get("/QLTD")).data;
    }
    async getMenu(loai) {
        return (await this.api.get(`/Menu/${loai}`)).data;
    }
    async delete(id) {
        return (await this.api.delete(`/QLTD/${id}`)).data;
    }

    async updateDish(id, data) {
        return (await this.api.put(`/QLTD/${id}`, data, {
            headers: {
                'Content-Type': 'multipart/form-data'
            }
        })).data;
    }
    async updateState(id, data) {
        return (await this.api.patch(`/QLTD/${id}`, data, {
        })).data;
    }
    async addDish(data) {
        return (await this.api.post('/QLTD', data, {
            headers: {
                'Content-Type': 'multipart/form-data'
            }
        })).data;
    }
}

export default new MenuService(); 