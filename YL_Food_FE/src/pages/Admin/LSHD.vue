<script>
import VueDatePicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';
import BillService from '@/services/bill.service';
import UserService from '@/services/user.service';
import { ref } from 'vue';

export default {
    components: { VueDatePicker },
    data() {
        return {
            ds: [],
            dstk: [],
            dsnv: [],
            so_ban: '',
            m: ref(
            ),
            date: ref(),


        }
    },
    methods: {
        async getAll() {
            this.ds = await BillService.getAll();
            this.dsnv = await UserService.getAll();
            this.dstk = this.ds;
        },
        search(event) {
            let dscurrent = [];
            dscurrent = this.filter();
            this.dstk = dscurrent.filter((e) => this.dsnv.filter((i) => i._id == e.ma_nhan_vien_xuat_don)[0].ma_nhan_vien_xuat_don.toLowerCase().includes(event.target.value.toLowerCase()))
        },
        toDate(date) {
            return date.toLocaleString('vi-VN', { timeZone: 'Asia/Ho_Chi_Minh' }).split(' ')[1];
        },
        filter() {
            if (this.date != undefined) {
                this.dstk = this.ds.filter((e) => this.toDate(e.thoi_gian) == this.toDate(this.date));
                let dstemp = [...this.dstk];
                if (this.so_ban!='') {
                    this.dstk = dstemp.filter((e) => e.so_ban == this.so_ban)
                }
            }
            else if (this.m != null) {
                this.dstk = this.ds.filter((e) => this.toDate(e.thoi_gian).includes(this.m.month + 1 + '/' + this.m.year));
                let dstemp = [...this.dstk];
                if (this.so_ban > 0) {
                    this.dstk = dstemp.filter((e) => e.so_ban == this.so_ban)
                }
            }
            else {
                if (this.so_ban > 0) {
                    this.dstk = this.ds.filter((e) => e.so_ban == this.so_ban)
                } else {
                    this.dstk = this.ds;
                }
            }
            return this.dstk;
        },
        tangDan() {
            this.dstk = this.dstk.sort(function (e1, e2) { return e1.tong_tien - e2.tong_tien });
        },
        giamDan() {
            this.dstk = this.dstk.sort(function (e1, e2) { return e2.tong_tien - e1.tong_tien });
        },
        format() {
            if (this.date != undefined) {
                const day = this.date.getDate();
                const month = this.date.getMonth() + 1;
                const year = this.date.getFullYear();

                return `${day}/${month}/${year}`;
            }
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
                        Sắp Xếp Tổng Tiền
                    </button>
                    <ul class="dropdown-menu rounded-0" aria-labelledby="dropdownMenuButton1">
                        <li><a @click="tangDan" class="dropdown-item" href="#">Tăng Dần</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a @click="giamDan" class="dropdown-item" href="#">Giảm Dần</a></li>
                    </ul>
                </div>

                <div class="dropdown ms-2">
                    <button class="btn btn-secondary dropdown-toggle rounded-0" type="button" id="dropdownMenuButton2"
                        data-bs-toggle="dropdown" aria-expanded="false">
                        Bộ Lọc
                    </button>
                    <ul class="dropdown-menu rounded-0" aria-labelledby="dropdownMenuButton2">
                        <li><a class="dropdown-item" href="#">Số Bàn</a></li>
                        <input type="text" class="form-control" placeholder="Nhập số bàn" v-model="so_ban" @input="filter">

                        <li><a class="dropdown-item" href="#">Ngày</a></li>
                        <VueDatePicker v-model="date" :format="format" @update:model-value="filter" :max-date="new Date()"></VueDatePicker>

                        <li><a class="dropdown-item" href="#">Tháng</a></li>
                        <VueDatePicker v-model="m" month-picker=true @update:model-value="filter"></VueDatePicker>
                    </ul>
                </div>
            </div>

            <div class="col-6 text-end">
                <input @input="search($event)" type="text" class="search" placeholder="Tìm kiếm theo mã nhân viên"
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
                        <th scope="col">Trạng Thái Hóa Đơn</th>
                        <th scope="col">Tổng Tiền</th>
                        <th scope="col">Tiền Giảm Giá</th>
                        <th scope="col">Tổng Tiền Thanh Toán</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(e, i) in this.dstk" :key="i">
                        <th scope="row">{{ e._id }}</th>
                        <td>{{ e.thoi_gian }}</td>
                        <td>Bàn Số {{ e.so_ban }}</td>
                        <td>{{ e.ma_nhan_vien_xuat_don }}</td>
                        <td>{{ e.trang_thai_hoa_don }}</td>
                        <td class="">{{ new Intl.NumberFormat('vi-VN').format(e.tong_tien/(1-e.gia_tri_giam_gia/100)) }}đ</td>
                        <td class="">{{ new Intl.NumberFormat('vi-VN').format((e.tong_tien/(1-e.gia_tri_giam_gia/100))*(e.gia_tri_giam_gia/100)) }}đ</td>
                        <td class="text-danger fw-bold">{{ new Intl.NumberFormat('vi-VN').format(e.tong_tien) }}đ</td>
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
    width: 50%;
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
    width: 80%;
}
</style>