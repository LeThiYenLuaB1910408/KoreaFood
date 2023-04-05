<script>
import SaleService from '@/services/sale.service'
export default {
    data() {
        return {
            ds: [],
            idEdit: null,
            khuyen_mai: {}
        }
    },
    methods: {
        async getAll() {
            this.ds = await SaleService.getAll();
        },
        async delete(id) {
            if (confirm('Xác nhận xóa khuyến mãi??')) {
                const rs = await SaleService.delete(id);
                alert(rs.message);
            }
            this.getAll();
        },
        async add() {
            const mkm = `KM${Number(this.ds[this.ds.length - 1]._id.slice(2, 3)) + 1}`;
            await SaleService.add({ mkm: mkm, ...this.khuyen_mai });
            this.initData();
            this.getAll();
        },
        setEdit(data) {
            this.khuyen_mai = data;
            this.idEdit = data._id;
        },
        async update() {
            await SaleService.update(this.idEdit, this.khuyen_mai);
            this.initData();
            this.getAll();
        },
        initData() {
            this.khuyen_mai = {};
            this.idEdit = null;
        }
    },
    mounted() {
        this.getAll();
    },
}
</script>

<template>
    <div class="title ps-4 py-3 mb-3">
        <h4 class="fw-bold">QUẢN LÝ KHUYẾN MÃI</h4>
    </div>
    <div class="container">
        <div class="d-flex justify-content-between" role="group" aria-label="Basic outlined example">
            <div class="btn-group col-4">
                <button type="button" class="btn active rounded-0" data-bs-toggle="modal" data-bs-target="#exampleModal"><i
                        class="fa-solid fa-plus me-2"></i>Thêm Khuyến Mãi</button>
                <button type="button" class="btn active rounded-0" @click="getAll">Làm Mới<i
                        class="fa-solid fa-rotate-right ms-2"></i></button>
            </div>
        </div>
        <div class="modal fade hide" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="staticBackdropLabel">Thông Tin Khuyến Mãi</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-4 mb-3 mt-3">
                                <label for="name" class="form-label">Tên Khuyến Mãi</label>
                                <input v-model="khuyen_mai.ten_khuyen_mai" type="text" class="form-control border rounded-0"
                                    id="mota" name="mota" />
                            </div>
                            <div class="col-4 mb-3 mt-3">
                                <label for="phantram" class="form-label">Phần Trăm Áp Dụng</label>
                                <input v-model="khuyen_mai.gia_tri" type="text" class="form-control border rounded-0"
                                    id="phantram" name="phantram" />
                            </div>
                            <div class="col-4 mb-3 mt-3">
                                <label for="rangbuoc" class="form-label">Số Tiền Ràng Buộc</label>
                                <input v-model="khuyen_mai.rang_buoc" type="text" class="form-control border rounded-0"
                                    id="rangbuoc" name="rangbuoc" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="mb-3 mt-3">
                                <label for="mota" class="form-label">Mô Tả:</label>
                                <input v-model="khuyen_mai.chi_tiet_khuyen_mai" type="text"
                                    class="form-control border rounded-0" id="price" name="price" />
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button @click="initData" type="button" class="btn btn-secondary rounded-0 px-3 py-2"
                            data-bs-dismiss="modal">Đóng</button>
                        <button v-if="this.idEdit == null" type="button" data-bs-dismiss="modal"
                            class="btn btn-success rounded-0 px-3 py-2" @click="add">Thêm</button>
                        <button v-else @click="update" type="button" data-bs-dismiss="modal"
                            class="btn btn-success rounded-0 px-3 py-2">Cập
                            Nhật</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row text-end me-5">
                <span>Tổng Số: <b>{{ this.ds.length }}</b> </span>
            </div>
            <table class="table table-hover text-center mt-3">
                <thead>
                    <tr>
                        <th scope="col">Mã</th>
                        <th scope="col">Tên Khuyến Mãi</th>
                        <th scope="col">Phần Trăm Áp Dụng</th>
                        <th scope="col">Số Tiền Ràng Buộc</th>
                        <th scope="col">Mô Tả</th>
                        <th scope="col">Khác</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(e, i) in this.ds" :key="i">
                        <th scope="row">{{ e._id }}</th>
                        <td>{{ e.ten_khuyen_mai }}</td>
                        <td>{{ e.gia_tri }}%</td>
                        <td>{{ e.rang_buoc }}đ</td>
                        <td>{{ e.chi_tiet_khuyen_mai }}</td>
                        <td><i class="fa-regular fa-pen-to-square me-2 fs-5" data-bs-toggle="modal"
                                data-bs-target="#exampleModal" @click="this.setEdit(e)"></i><i
                                class="fa-regular fa-trash-can fs-5" @click="this.delete(e._id)"></i>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>

<style scoped>
.title {
    box-shadow: 5px 1px 10px 0px grey;
}

div>button {
    padding: 12px 6px;
}

.active {
    border: 1px solid grey !important;
    color: grey !important;
    font-weight: bold;
}

.active:hover,
.active:active {
    background-color: grey !important;
    color: white !important;
    font-weight: bold;
}

th,
td {
    vertical-align: middle;
}

td i {
    cursor: pointer;
}
</style>