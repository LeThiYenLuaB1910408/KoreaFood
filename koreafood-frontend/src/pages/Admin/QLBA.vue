<script>
import TableService from '@/services/table.service';
import { toast } from 'vue3-toastify';
import 'vue3-toastify/dist/index.css';

export default {
    data() {
        return {
            ds: [],
            so_ban: '',
            ban_an: {},
            idEdit: null,
            so_cho_ngoi: null
        }
    },
    methods: {
        async getTable() {
            this.ds = await TableService.getTable()
        },
        async delete(id) {
            toast("Xóa Thành Công", {
                autoClose: 1000,
                type: 'success',
                theme: 'colored'
            });
            const result = await TableService.delete(id);
            this.getTable();
        },
        async addTable() {
            toast("Thêm Thành Công", {
                autoClose: 1000,
                type: 'success',
                theme: 'colored'
            });
            const rs = await TableService.addTable({ so_ban: this.so_ban, so_cho_ngoi: this.so_cho_ngoi });
            this.getTable();
        },
        setEdit(data) {
            this.ban_an = data;
            this.idEdit = data._id;
        },
        initData() {
            this.ban_an = {};
            this.idEdit = null;
        }
    },
    mounted() {
        this.getTable();
    },
}
</script>

<template>
    <div class="title ps-4 py-3 mb-3 position-sticky top-0 bg-light" style="z-index: 1000;">
        <h4 class="fw-bold">QUẢN LÝ BÀN ĂN</h4>
    </div>
    <div class="container">
        <div class="d-flex justify-content-between" role="group" aria-label="Basic outlined example">
            <div class="btn-group col-4">
                <button type="button" class="btn active rounded-0" data-bs-toggle="modal" data-bs-target="#exampleModal"><i
                        class="fa-solid fa-plus me-2"></i>Thêm Bàn</button>
                <button type="button" class="btn active rounded-0" @click="getTable">Làm Mới<i
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
            <div class="modal-dialog modal-dialog-scrollable modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="staticBackdropLabel">Thông Tin Bàn Ăn</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-6 mb-3 mt-3">
                                <label for="sb" class="form-label">Số Bàn</label>
                                <input v-model="so_ban" type="text" class="form-control border rounded-0" id="sb"
                                    name="sb" />
                            </div>
                            <div class="col-6 mb-3 mt-3">
                                <label for="cn" class="form-label">Số Chỗ Ngồi:</label>
                                <input v-model="so_cho_ngoi" type="text" class="form-control border rounded-0" id="cn"
                                    name="cn" />
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary rounded-0 px-3 py-2"
                            data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" data-bs-dismiss="modal" class="btn btn-success rounded-0 px-3 py-2"
                            @click="addTable()">Thêm</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row text-end me-5">
                <span>Tổng Số: <b>{{ this.ds.length }}</b> </span>
            </div>
            <div class="row">
                <div class="col-9">
                    <div class="row justify-content-center">
                        <div class="col-3 d-flex me-3  mb-3" v-for="(e, i) in this.ds" :key="i">
                            <h4 v-if="e.trang_thai_ban_an === 'Trống'"
                                class="col-12 text-light sb text-center py-5 rounded-2">Bàn {{ e._id }}</h4>
                            <h4 v-else-if="e.trang_thai_ban_an === 'Đang chuẩn bị'"
                                class="col-12 text-light sb1 text-center py-5 rounded-2">Bàn {{ e._id }}</h4>
                            <h4 v-else-if="e.trang_thai_ban_an === 'Đang đợi thanh toán'"
                                class="col-12 text-light sb3 text-center py-5 rounded-2">Bàn {{ e._id }}</h4>
                            <h4 v-else="e.trang_thai_ban_an === 'Hoàn thành'"
                                class="col-12 text-light sb2 text-center py-5 rounded-2">Bàn {{ e._id }}</h4>
                            <i class="fa-regular fa-square-minus fs-4 ms-1 text-danger" @click="this.setEdit(e)"
                                style="cursor: pointer;" data-bs-toggle="modal" data-bs-target="#exampleModal1"></i>
                        </div>
                    </div>
                </div>
                <div class="col-3 mt-5">
                    <p><i class="fa-solid fa-circle me-1 empty"></i>Trống</p>
                    <p><i class="fa-solid fa-circle me-1 wait"></i>Đang Đợi Món</p>
                    <p><i class="fa-solid fa-circle me-1 wait-payment"></i>Đang Đợi Thanh Toán</p>
                    <p><i class="fa-solid fa-circle me-1 finish"></i>Hoàn Thành</p>
                </div>

            </div>
        </div>
    </div>
</template>

<style scoped>
.title {
    box-shadow: 5px 1px 10px 0px grey;
}

button {
    padding: 12px 6px;
}

.sb {
    background-color: rgb(185, 183, 183);
    border: 1px solid rgb(185, 183, 183);
    box-shadow: 0px 1px 2px 0px grey;

}

.sb1 {
    background-color: rgb(225, 207, 41);
    border: 1px solid rgb(225, 207, 41);
    box-shadow: 0px 1px 2px 0px grey;
}

.sb2 {
    background-color: rgb(44, 157, 44);
    border: 1px solid rgb(44, 157, 44);
    box-shadow: 0px 1px 2px 0px grey;
}

.sb3 {
    background-color: orange;
    border: 1px solid orange;
    box-shadow: 0px 1px 2px 0px grey;
}

.empty {
    color: rgb(185, 183, 183);
}

.wait {
    color: rgb(225, 207, 41);
}

.wait-payment {
    color: orange;
}

.finish {
    color: rgb(44, 157, 44);
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
</style>