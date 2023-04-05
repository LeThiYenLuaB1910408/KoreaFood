<script>
import VueDatePicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';
import BillService from '@/services/bill.service';
import { ref } from 'vue';

export default {
    components: { VueDatePicker },
    data() {
        return {
            ds: [],
            dstk: [],
            m: ref({
                mth: new Date().getMonth(),
                y: new Date().getFullYear(),
            })

        }
    },
    methods: {
        async getAll() {
            this.ds = await BillService.getAll();
            this.dstk = this.ds;
        },
        search(event) {
            this.dstk = this.ds.filter((e) => e.ma_nhan_vien_lap_don.toLowerCase().includes(event.target.value.toLowerCase()))
        }
    },
    mounted() {
        this.getAll();
    },
};
</script>

<template>
    <div class="title ps-4 py-3 mb-3">
        <h4 class="fw-bold">LỊCH SỬ HÓA ĐƠN</h4>
    </div>
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-6 d-flex">
                <div class="dropdown me-2">
                    <button class="btn btn-secondary dropdown-toggle rounded-0" type="button" id="dropdownMenuButton1"
                        data-bs-toggle="dropdown" aria-expanded="false">
                        Sắp Xếp
                    </button>
                    <ul class="dropdown-menu rounded-0" aria-labelledby="dropdownMenuButton1">
                        <li><a class="dropdown-item" href="#">Tăng Dần</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a class="dropdown-item" href="#">Giảm Dần</a></li>
                    </ul>
                </div>
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle rounded-0" type="button" id="dropdownMenuButton2"
                        data-bs-toggle="dropdown" aria-expanded="false">
                        Hiển Thị Theo
                    </button>
                    <ul class="dropdown-menu rounded-0" aria-labelledby="dropdownMenuButton2">
                        <li><a class="dropdown-item" href="#">Ngày</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a class="dropdown-item" href="#">Mã Hóa Đơn</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a class="dropdown-item" href="#">Mã Nhân Viên</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a class="dropdown-item" href="#">Tổng Tiền Thanh Toán</a></li>
                    </ul>
                </div>
                <div class="dropdown ms-2">
                    <button class="btn btn-secondary dropdown-toggle rounded-0" type="button" id="dropdownMenuButton2"
                        data-bs-toggle="dropdown" aria-expanded="false">
                        Lọc
                    </button>
                    <ul class="dropdown-menu rounded-0" aria-labelledby="dropdownMenuButton2">
                        <VueDatePicker v-model="m" month-picker=true></VueDatePicker>
                    </ul>
                </div>
            </div>

            <div class="col-6 text-end">
                <input @input="search($event)" type="text" class="search" placeholder="Tìm kiếm..."
                    aria-label="Example text with button addon" aria-describedby="button-addon1">
            </div>
        </div>
        <div class="container">
            <div class="row text-end me-3 mt-3">
                <span>Tổng Số: <b>{{ this.dstk.length }}</b> </span>
            </div>
            <table class="table table-hover text-center mt-3">
                <thead>
                    <tr>
                        <th scope="col">Mã Hóa Đơn</th>
                        <th scope="col">Ngày - Giờ</th>
                        <th scope="col">Số Bàn</th>
                        <th scope="col">Nhân Viên Thanh Toán</th>
                        <th scope="col">Tổng Tiền Thanh Toán</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(e, i) in this.dstk" :key="i">
                        <th scope="row">{{ e._id }}</th>
                        <td>{{ e.thoi_gian }}</td>
                        <td>Bàn Số {{ e.so_ban }}</td>
                        <td>{{ e.ma_nhan_vien_lap_don }}</td>
                        <td class="text-danger fw-bold">{{ e.tong_tien }}đ</td>
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