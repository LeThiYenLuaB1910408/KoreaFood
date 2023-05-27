<script>
import UserService from "@/services/user.service";
import { toast } from 'vue3-toastify';
import 'vue3-toastify/dist/index.css';

export default {
    data() {
        return {
            ds: [],
            dstk: [],
            idEdit: null,
            selected: {
                tai_khoan: {}
            },
            nhan_vien: {
                tai_khoan: {}
            }
        }
    },
    methods: {
        async getAll() {
            this.ds = await UserService.getAll();
            this.dstk = this.ds;
        },
        async addUser() {
            const mnv = `NV${Number(this.ds[this.ds.length - 1]._id.split('V')[1]) + 1}`;
            const rs = await UserService.addUser({ mnv: mnv, ...this.nhan_vien });
            toast("Thêm Thành Công", {
                autoClose: 1000,
                type: 'success',
                theme: 'colored'
            });
            this.initData();
            this.getAll();
        },
        async update() {
            const result = await UserService.update(this.idEdit, this.nhan_vien);
            this.getAll();
            toast("Cập Nhật Thành Công", {
                autoClose: 1000,
                type: 'success',
                theme: 'colored'
            });
            this.initData();
        },
        async delete(id) {
            toast("Xóa Thành Công", {
                autoClose: 1000,
                type: 'success',
                theme: 'colored'
            });
            const result = await UserService.delete(id);
            this.getAll();
        },
        search(event) {
            this.dstk = this.ds.filter((e) => e.ho_ten.toLowerCase().includes(event.target.value.toLowerCase())
            )
        },
        setEdit(data) {
            this.idEdit = data._id,
                this.nhan_vien = data
        },
        initData() {
            this.nhan_vien = {
                tai_khoan: {}
            }
            this.idEdit = null;
        }
    },
    created() {
        this.getAll();
    },
}
</script>

<template>
    <div class="title ps-4 py-3 mb-3">
        <h4 class="fw-bold">QUẢN LÝ NHÂN VIÊN</h4>
    </div>
    <div class="container">
        <div class="d-flex justify-content-between" role="group" aria-label="Basic outlined example">
            <div class="btn-group col-4">
                <button type="button" class="btn active rounded-0" data-bs-toggle="modal" data-bs-target="#exampleModal"><i
                        class="fa-solid fa-plus me-2"></i>Thêm Nhân
                    Viên</button>
                <button type="button" class="btn active rounded-0" @click="getAll">Làm Mới<i
                        class="fa-solid fa-rotate-right ms-2"></i></button>
            </div>
            <div class="col-6 text-end">
                <input @input="search($event)" type="text" class="search" placeholder="Tìm kiếm..."
                    aria-label="Example text with button addon" aria-describedby="button-addon1">
            </div>
        </div>
        <div class="modal fade hide " id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel"
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
                        <h5 class="modal-title" id="staticBackdropLabel">Thông Tin Nhân Viên</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-5 mb-3 mt-3">
                                <label for="ht" class="form-label">Họ Và Tên</label>
                                <input v-model="nhan_vien.ho_ten" type="text" class="form-control border rounded-0" id="ht"
                                    name="ht" />
                            </div>
                            <div class="col-md-4 mb-3 mt-3">
                                <label for="sdt" class="form-label">Số điện thoại:</label>
                                <input v-model="nhan_vien.so_dien_thoai" type="text" class="form-control border rounded-0"
                                    id="sdt" name="sdt" />
                            </div>
                            <div class=" col-md-3 mb-3 mt-3">
                                <label for="lh" class="form-label">Giới Tính</label>
                                <select id="inputState" class="form-select" v-model="nhan_vien.gioi_tinh">
                                    <option selected>- Chọn -</option>
                                    <option value="Nam">Nam</option>
                                    <option value="Nữ">Nữ</option>
                                </select>
                            </div>

                        </div>

                        <div class="row">
                            <div class="col-4 my-3">
                                <label for="cccd" class="form-label">CCCD/CMND:</label>
                                <input v-model="nhan_vien.cccd" type="text" class="form-control border rounded-0" id="dc"
                                    name="dc" />
                            </div>
                            <div class="col-4 my-3">
                                <label for="email" class="form-label">Email:</label>
                                <input v-model="nhan_vien.email" type="text" class="form-control border rounded-0"
                                    id="email" name="email" />
                            </div>
                            <div class="col-4 my-3">
                                <label for="dc" class="form-label">Địa Chỉ:</label>
                                <input v-model="nhan_vien.dia_chi" type="text" class="form-control border rounded-0" id="dc"
                                    name="dc" />
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-4 my-3">
                                <label for="ns" class="form-label">Ngày Sinh:</label>
                                <input v-model="nhan_vien.ngay_sinh" type="date" class="form-control border rounded-0"
                                    id="ns" name="ns" />
                            </div>
                            <div class="col-md-4 mb-3 mt-3">
                                <label for="nbd" class="form-label">Ngày Bắt Đầu Làm Việc:</label>
                                <input v-model="nhan_vien.tai_khoan.ngay_bat_dau_lam_viec" type="date"
                                    class="form-control border rounded-0" id="nbd" name="nbd" />
                            </div>
                            <div class="col-md-4 mb-3 mt-3">
                                <label for="cv" class="form-label">Chức Vụ</label>
                                <select id="inputState" class="form-select" v-model="nhan_vien.tai_khoan.cap_quyen">
                                    <option selected>- Chọn -</option>
                                    <option value="2">Thu Ngân</option>
                                    <option value="0">Nhân Viên Phục Vụ</option>
                                </select>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button @click="initData" type="button" class="btn btn-secondary rounded-0"
                            data-bs-dismiss="modal">Đóng</button>
                        <button @click="addUser" v-if="this.idEdit === null" type="button" data-bs-dismiss="modal"
                            class="btn btn-success rounded-0">Thêm</button>
                        <button @click="update" v-else type="button" data-bs-dismiss="modal"
                            class="btn btn-success rounded-0">Cập
                            Nhật</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="row text-end me-3 mt-3">
            <span>Tổng Số: <b>{{ this.dstk.length }}</b> </span>
        </div>
        <table class="table table-hover text-center mt-3">
            <thead>
                <tr>
                    <th scope="col">Mã</th>
                    <th scope="col">Họ Và Tên</th>
                    <th scope="col">Giới Tính</th>
                    <th scope="col">Email</th>
                    <th scope="col">Địa Chỉ</th>
                    <th scope="col">Chức Vụ</th>
                    <th scope="col">Khác</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(e, i) in this.dstk" :key="i">
                    <th scope="row">{{ e._id }}</th>
                    <td>{{ e.ho_ten }}</td>
                    <td>{{ e.gioi_tinh }}</td>
                    <td>{{ e.email }}</td>
                    <td>{{ e.dia_chi }}</td>
                    <td v-if="e.tai_khoan.cap_quyen == 1">Chủ Quán/Quản Lý</td>
                    <td v-else-if="e.tai_khoan.cap_quyen == 0">Nhân Viên Phục Vụ</td>
                    <td v-else>Thu Ngân</td>
                    <td><i @click="setEdit(e)" class="fa-regular fa-pen-to-square me-2 fs-5" data-bs-toggle="modal"
                            data-bs-target="#exampleModal"></i><i class="fa-regular fa-trash-can fs-5"
                            @click="this.setEdit(e)" data-bs-toggle="modal" data-bs-target="#exampleModal2"></i>
                        <button class="border-0" style="background-color: transparent;" data-bs-toggle="modal"
                            data-bs-target="#exampleModal1" @click="this.selected = e">
                            <i class="fa-solid fa-circle-info fs-5"></i>
                        </button>
                    </td>
                </tr>
                <div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel"
                    aria-hidden="true">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="staticBackdropLabel">Thông Tin Nhân Viên</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row mt-2">
                                    <div class="col-3"><img :src="`src/assets/images/${this.selected.hinh_anh_tai_khoan}`"
                                            alt="avatar" style="width: 90%;"></div>
                                    <div class="col-4 text-start">
                                        <p><b>Họ Và Tên: </b>{{ this.selected.ho_ten }}</p>
                                        <p><b>Ngày Sinh: </b>{{ this.selected.ngay_sinh }}</p>
                                        <p><b>Số Điện Thoại: </b>{{ this.selected.so_dien_thoai }}</p>
                                        <p class="p-0 m-0"><b>Địa Chỉ: </b>{{ this.selected.dia_chi }}</p>
                                    </div>
                                    <div class="col-5 text-start">
                                        <p><b>CCCD: </b>{{ this.selected.cccd }}</p>
                                        <p><b>Tên Tài Khoản: </b>{{ this.selected.tai_khoan.ten_dang_nhap }}</p>
                                        <p v-if="this.selected.tai_khoan.cap_quyen == 0"><b>Vị Trí: </b>Nhân Viên Phục Vụ
                                        </p>
                                        <p v-else-if="this.selected.tai_khoan.cap_quyen == 2"><b>Vị Trí: </b> Thu Ngân
                                        </p>
                                        <p v-else><b>Vị Trí: </b>Chủ Quán</p>
                                        <p class="m-0 p-0"><b>Ngày Bắt Đầu Làm Việc: </b>{{
                                            this.selected.tai_khoan.ngay_bat_dau_lam_viec }}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                            </div>
                        </div>
                    </div>
                </div>
            </tbody>
        </table>
    </div>
</template>

<style scoped>
.title {
    box-shadow: 5px 1px 10px 0px grey;
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

.search {
    width: 25%;
    border: 2px solid #ccc;
    font-size: 16px;
    background-color: white;
    background-image: url('@/assets/searchicon.png');
    background-position: 10px 10px;
    background-repeat: no-repeat;
    padding: 10px 20px 12px 40px;
    outline: none;
    transition: width 0.8s ease-in-out;
}

.search:focus {
    border: 1px solid grey;
    width: 70%;
}

td i {
    cursor: pointer;
}
</style>