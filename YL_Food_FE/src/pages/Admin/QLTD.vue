<script>
import MenuService from "@/services/menu.service";
import { toast } from 'vue3-toastify';
import 'vue3-toastify/dist/index.css';

export default {
    data() {
        return {
            ds: [],
            dstk: [],
            mon_an: {},
            hinh_anh: '',
            idEdit: null
        }
    },
    methods: {
        async getData() {
            this.ds = await MenuService.getAll();
            this.dstk = this.ds;
        },

        changeFile(event) {
            const file = event.target.files[0];
            this.hinh_anh = file;
        },
        buildFormData(formData, data, parentKey) {
            if (data && typeof data === 'object' && !(data instanceof Date) && !(data instanceof File)) {
                Object.keys(data).forEach(key => {
                    this.buildFormData(formData, data[key], parentKey ? `${parentKey}[${key}]` : key);
                });
            } else {
                const value = data == null ? '' : data;
                formData.append(parentKey, value);
            }
        },
        async addDish() {
            const msp = `M${Number(this.ds[this.ds.length - 1]._id.slice(1, 3)) + 1}`;
            var formData = new FormData();
            formData.append('file', this.hinh_anh);
            this.buildFormData(formData, { ...this.mon_an, msp: msp })
            const rs = await MenuService.addDish(formData);
            toast("Thêm Thành Công", {
                autoClose: 1000,
                type: 'success',
                theme: 'colored'
            });
            this.initData();
            this.getData();
        },
        async delete(id) {
            toast("Xóa Thành Công", {
                autoClose: 1000,
                type: 'success',
                theme: 'colored'
            });
            const rs = await MenuService.delete(id);
            this.getData();
        },
        async updateDish() {
            var formData = new FormData();
            formData.append('file', this.hinh_anh);
            this.buildFormData(formData, { ...this.mon_an, msp: this.idEdit })
            const rs = await MenuService.updateDish(this.idEdit, formData);
            toast("Cập Nhật Thành Công", {
                autoClose: 1000,
                type: 'success',
                theme: 'colored'
            });
            this.initData();
            this.getData();
        },
        search(event) {
            this.dstk = this.ds.filter((e) => e.ten_mon_an.toLowerCase().includes(event.target.value.toLowerCase()))
        },
        setEdit(data) {
            this.mon_an.ten_mon = data.ten_mon_an;
            this.mon_an.gia = data.gia_mon_an;
            this.mon_an.id_loai_mon = data.id_loai_mon_an;
            this.mon_an.trang_thai_mon_an = data.trang_thai_mon_an;
            this.idEdit = data._id;
        },
        initData() {
            this.mon_an = {};
            this.idEdit = null;
        }

    },
    mounted() {
        this.getData();
    }
}
</script>

<template>
    <div class="title ps-4 py-3 mb-3 position-sticky top-0 bg-light" style="z-index: 100">
        <h4 class="fw-bold">QUẢN LÝ THỰC ĐƠN</h4>
    </div>
    <div class="container">
        <div class="d-flex justify-content-between" role="group" aria-label="Basic outlined example">
            <div class="btn-group col-4">
                <button type="button" class="btn active rounded-0" data-bs-toggle="modal" data-bs-target="#exampleModal"><i
                        class="fa-solid fa-plus me-2"></i>Thêm Món</button>
                <button type="button" class="btn active rounded-0" @click="getData">Làm Mới<i
                        class="fa-solid fa-rotate-right ms-2"></i></button>
            </div>
            <div class="col-6 text-end">
                <input type="text" class="search" @input="search($event)" placeholder="Tìm kiếm..."
                    aria-label="Example text with button addon" aria-describedby="button-addon1">
            </div>
        </div>
        <div class="modal fade hide " id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel1"
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
                        <h5 class="modal-title" id="staticBackdropLabel">Thông Tin Món Ăn</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-6 my-3">
                                <label for="name" class="form-label">Tên Món</label>
                                <input v-model="mon_an.ten_mon" type="text" class="form-control border rounded-0" id="name"
                                    name="name" />
                            </div>
                            <div class="col-3 my-3">
                                <label for="price" class="form-label">Giá:</label>
                                <input v-model="mon_an.gia" type="text" class="form-control border rounded-0" id="price"
                                    name="price" />
                            </div>
                            <div class="col-3 my-3">
                                <label for="state" class="form-label">Trạng Thái:</label>
                                <div class="form-check">
                                    <input class="form-check-input" id="flexRadioDefault1" value="1"
                                        v-model="mon_an.trang_thai_mon_an" type="radio" name="flexRadioDefault">
                                    <label class="form-check-label" for="flexRadioDefault1">
                                        Đang Bán
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" id="flexRadioDefault2" value="0"
                                        v-model="mon_an.trang_thai_mon_an" type="radio" name="flexRadioDefault">
                                    <label class="form-check-label" for="flexRadioDefault2">
                                        Tạm Ngừng Bán
                                    </label>
                                </div>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6 my-3">
                                <label for="loai" class="form-label">Loại Món Ăn:</label>
                                <select v-model="mon_an.id_loai_mon" class="form-select"
                                    aria-label="Default select example">
                                    <option selected>-- Chọn --</option>
                                    <option value="L01">Đồ Ăn</option>
                                    <option value="L02">Đồ Uống</option>
                                    <option value="L03">Món Thêm</option>
                                </select>
                            </div>
                            <div class="col-6 my-3">
                                <label for="ha" class="form-label">Hình Ảnh:</label>
                                <input @change="changeFile($event)" type="file" class="form-control" id="ha"
                                    accept="image/png, image/gif, image/jpeg">
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button @click="initData" type="button" class="btn btn-secondary rounded-0 px-3 py-2"
                            data-bs-dismiss="modal">Đóng</button>
                        <button type="button" v-if="this.idEdit == null" @click="addDish" data-bs-dismiss="modal"
                            class="btn btn-success rounded-0 px-3 py-2">Thêm</button>
                        <button type="button" v-else @click="updateDish()" data-bs-dismiss="modal"
                            class="btn btn-success rounded-0 px-3 py-2">Cập Nhật</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="container mt-3">
            <div class="row text-end me-5">
                <span>Tổng Số: <b>{{ this.ds.length }}</b> </span>
            </div>
            <table class="table table-hover text-center mt-3">
                <thead>
                    <tr>
                        <th scope="col">MSP</th>
                        <th scope="col">Hình Ảnh</th>
                        <th scope="col">Tên Món</th>
                        <th scope="col">Giá</th>
                        <th scope="col">Trạng Thái</th>
                        <th scope="col">Loại Món Ăn</th>
                        <th scope="col">Khác</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(e, i) in this.dstk" :key="i">
                        <th scope="row">{{ e._id }}</th>
                        <td><img :src="`src/assets/images/${e.hinh_anh_mon_an}`" alt="" width="90"></td>
                        <td>{{ e.ten_mon_an }}</td>
                        <td>{{ new Intl.NumberFormat('vi-VN').format(e.gia_mon_an) }}đ</td>
                        <td v-if="e.trang_thai_mon_an == 1">Đang Bán</td>
                        <td v-else>Tạm Ngừng Bán</td>
                        <td>{{ e.id_loai_mon_an }}</td>
                        <td><i class="fa-regular fa-pen-to-square me-2 fs-5" @click="this.setEdit(e)" data-bs-toggle="modal"
                                data-bs-target="#exampleModal"></i><i class="fa-regular fa-trash-can fs-5"
                                @click="this.setEdit(e)" data-bs-toggle="modal" data-bs-target="#exampleModal1"></i>
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
</style>