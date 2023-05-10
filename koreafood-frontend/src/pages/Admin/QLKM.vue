<script>
import SaleService from '@/services/sale.service';
import { toast } from 'vue3-toastify';
import 'vue3-toastify/dist/index.css';

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
            toast("Xóa Thành Công", {
                autoClose: 1000,
                type: 'success',
                theme: 'colored'
            });
            const rs = await SaleService.delete(id);
            this.getAll();
        },
        async add() {
            try {
                let mkm;
                if (this.ds.length > 0) {
                    mkm = `KM${Number(this.ds[this.ds.length - 1]._id.slice(2, 3)) + 1}`;
                } else {
                    mkm = 'KM1';
                }
                toast("Thêm Thành Công", {
                    autoClose: 1000,
                    type: 'success',
                    theme: 'colored'
                });
                await SaleService.add({ mkm: mkm, ...this.khuyen_mai });
                this.initData();
                this.getAll();
            } catch (error) {
                toast("Thêm Không Thành Công", {
                    autoClose: 1000,
                    type: 'error',
                    theme: 'colored'
                });
            }

        },
        setEdit(data) {
            this.khuyen_mai = data;
            this.idEdit = data._id;
        },
        async update() {
            toast("Cập Nhật Thành Công", {
                autoClose: 1000,
                type: 'success',
                theme: 'colored'
            });
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
        <div class="modal fade hide " id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel"
            aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-md modal-dialog-centered ">
                <div class="modal-content rounded-0">
                    <h5 class="modal-title text-center my-3" id="staticBackdropLabel">BẠN CÓ CHẮC CHẮN MUỐN XÓA?</h5>
                    <div class="modal-body text-center">
                        <i class="fa-regular fa-circle-xmark text-danger" style="font-size: 150px;"></i>
                    </div>
                    <div class="d-flex justify-content-center my-3">
                        <button @click="initData" type="button" class="btn btn-secondary rounded-0 px-3 py-2 me-1"
                            data-bs-dismiss="modal">Hủy</button>
                        <button type="button" data-bs-dismiss="modal" class="btn btn-danger rounded-0 px-3 py-2"
                            @click="this.delete(this.idEdit)">Xóa</button>

                    </div>

                </div>
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
                            <div class="col-md-6 mb-3 mt-3">
                                <label for="nbd" class="form-label">Ngày Bắt Đầu Áp Dụng:</label>
                                <input v-model="khuyen_mai.ngay_bat_dau" type="date" class="form-control border rounded-0"
                                    id="nbd" name="nbd" />
                            </div>
                            <div class="col-md-6 mb-3 mt-3">
                                <label for="nkt" class="form-label">Ngày Kết Thúc Khuyến Mãi:</label>
                                <input v-model="khuyen_mai.ngay_ket_thuc" type="date" class="form-control border rounded-0"
                                    id="nkt" name="nkt" />
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
                        <th scope="col">Phần Trăm</th>
                        <th scope="col">Ràng Buộc</th>
                        <th scope="col">Ngày Bắt Đầu</th>
                        <th scope="col">Ngày Kết Thúc</th>
                        <th scope="col">Mô Tả</th>
                        <th scope="col">Khác</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(e, i) in this.ds" :key="i">
                        <th scope="row">{{ e._id }}</th>
                        <td>{{ e.ten_khuyen_mai }}</td>
                        <td>{{ e.gia_tri }}%</td>
                        <td>{{ new Intl.NumberFormat('vi-VN').format(e.rang_buoc) }}đ</td>
                        <td>{{ e.ngay_bat_dau }}</td>
                        <td>{{ e.ngay_ket_thuc }}</td>
                        <td>{{ e.chi_tiet_khuyen_mai }}</td>
                        <td><i class="fa-regular fa-pen-to-square me-2 fs-5" data-bs-toggle="modal"
                                data-bs-target="#exampleModal" @click="this.setEdit(e)"></i><i
                                class="fa-regular fa-trash-can fs-5" @click="this.setEdit(e)" data-bs-toggle="modal"
                                data-bs-target="#exampleModal1"></i>
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