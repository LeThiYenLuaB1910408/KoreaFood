<script>
import { Bar, Line } from 'vue-chartjs';
import MenuService from '@/services/menu.service';
import BillService from '@/services/bill.service';
import UserService from '@/services/user.service';
import {
    Chart as ChartJS, Title, Tooltip, PointElement, Legend,
    LineElement, BarElement, CategoryScale, LinearScale
} from 'chart.js'
ChartJS.register(Tooltip, BarElement, CategoryScale, LinearScale, PointElement, Legend,
    LineElement, Title)
export default {
    name: 'BarChart',
    components: { Line },
    data() {
        return {
            menu: [],
            dshd: [],
            dsnd: [],
            so_luong_nv: 0,
            so_luong_mon_an: 30,
            so_luong_hd: 0,
            tong_tien: 0,
            total: 0,
            data: {
                labels: [],
                datasets: [
                    {
                        label: 'Số Lượng Đã Bán',
                        backgroundColor: '#298ee1a8',
                        borderColor: '#298ee1f8',
                        data: [],
                        pointStyle: 'circle',
                        pointRadius: 10,
                        pointHoverRadius: 15
                    },
                ],
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        position: 'top',
                    }
                },
                scales: {
                    x: {
                        grid: {
                            display: false
                        }
                    },
                    y: {
                        grid: {
                            display: false
                        }
                    }
                }

            }
        }
    },
    methods: {
        async getAll() {
            this.menu = (await MenuService.getAll()).sort(function (e1, e2) { return e2.so_luong_ban_ra - e1.so_luong_ban_ra });
            this.dsnd = await UserService.getAll();
            this.dshd = await BillService.getAll();
            this.so_luong_mon_an = this.menu.length - 30;
            // 

            this.so_luong_nv = this.dsnd.filter((e) => e.tai_khoan.ngay_bat_dau_lam_viec.split('-')[1] == new Date().getMonth() + 1).length;

            let dshd_cu = this.dshd.filter((e) => e.thoi_gian.split('/')[1] == new Date().getMonth());
            let dshd_moi = this.dshd.filter((e) => e.thoi_gian.split('/')[1] == new Date().getMonth() + 1);

            let so_luong_hd_moi = dshd_moi.length;
            let so_luong_hd_cu = dshd_cu.length;
            if (so_luong_hd_cu > 0) {
                this.so_luong_hd = ((so_luong_hd_moi / so_luong_hd_cu) * 100 - 100);
            } else {
                this.so_luong_hd = 100;
            }
            this.total = this.dshd.reduce((sum, value) => sum + value.tong_tien, 0);
            let tong_tien_cu = dshd_cu.reduce((sum, value) => sum + value.tong_tien, 0);
            let tong_tien_moi = dshd_moi.reduce((sum, value) => sum + value.tong_tien, 0);
            if (tong_tien_cu > 0) {
                this.tong_tien = ((tong_tien_moi / tong_tien_cu) * 100 - 100);
            } else {
                this.tong_tien = 100;
            }

            for (let i = 0; i < 7; i++) {
                this.data.labels.push(this.menu[i].ten_mon_an);
            }

            let data = [];
            for (let i = 0; i < 7; i++) {
                data.push(this.menu[i].so_luong_ban_ra);
            }
            this.data.datasets[0].data = [...data]; ``
            let date = this.dshd[0].thoi_gian.split(' ')[1].split('/');
            console.log(new Date(date[2], date[1] - 1, date[0]).getDay() + 1);
        }
    },
    created() {
        this.getAll();
    }
}
</script>

<template>
    <div class="title ps-4 py-3 mb-3">
        <h4 class="fw-bold">TỔNG QUAN</h4>
    </div>
    <div class="dashboard">
        <div class="container">
            <h6>TỔNG QUÁT</h6>
            <div class="row my-4 justify-content-center">
                <div class="col-3 tong-quat">
                    <div class="justify-content-between d-flex">
                        <span class="text-secondary">Tổng Số Nhân Viên</span><i class="fa-regular fa-circle-user fs-3 mt-1"
                            style="color:blue"></i>
                    </div>
                    <div class="so-luong d-flex my-3">
                        <h4>{{ this.dsnd.length }}</h4>
                        <span class="ms-3 growth h-25 px-2 py-1"><i class="fa-solid fa-arrow-trend-up pe-1"></i>{{
                            this.so_luong_nv }}</span>
                    </div>
                </div>
                <div class="col-3 tong-quat">
                    <div class="justify-content-between d-flex">
                        <span class="text-secondary">Tổng Số Món Ăn</span><i class="fa-solid fa-plate-wheat fs-3 mt-1"
                            style="color:yellowgreen"></i>
                    </div>
                    <div class="so-luong d-flex my-3">
                        <h4>{{ this.menu.length }}</h4>
                        <span class="ms-3 growth h-25 px-2 py-1" v-if="this.so_luong_mon_an >= 0"><i
                                class="fa-solid fa-arrow-trend-up pe-1"></i>{{ this.so_luong_mon_an }}</span>
                        <span class="ms-3 down h-25 px-2 py-1" v-else><i class="fa-solid fa-arrow-trend-down pe-1"></i>{{
                            this.so_luong_mon_an * -1 }}</span>
                    </div>
                </div>
                <div class="col-3 tong-quat">
                    <div class="justify-content-between d-flex">
                        <span class="text-secondary">Tổng Số Hóa Đơn</span><i class="fa-solid fa-receipt fs-3 mt-1"
                            style="color:red"></i>
                    </div>
                    <div class="so-luong d-flex my-3">
                        <h4>{{ this.dshd.length }}</h4>
                        <span class="ms-3 growth h-25 px-2 py-1" v-if="this.so_luong_hd > 0"><i
                                class="fa-solid fa-arrow-trend-up pe-1"></i>{{ this.so_luong_hd.toFixed(2) }}%</span>
                        <span class="ms-3 down h-25 px-2 py-1" v-else><i class="fa-solid fa-arrow-trend-down pe-1"></i>{{
                            this.so_luong_hd.toFixed(2) * -1 }}%</span>
                    </div>
                </div>
                <div class="col-3 tong-quat">
                    <div class="justify-content-between d-flex">
                        <span class="text-secondary">Tổng Doanh Thu</span><i class="fa-solid fa-coins fs-3 mt-1"
                            style="color: rgb(225, 207, 41)"></i>
                    </div>
                    <div class="so-luong d-flex my-3">
                        <h4>{{ new Intl.NumberFormat('vi-VN').format(this.total) }}<sup>đ</sup></h4>
                        <span class="ms-3 growth h-25 px-2 py-1" v-if="this.tong_tien > 0"><i
                                class="fa-solid fa-arrow-trend-up pe-1"></i>{{ this.tong_tien.toFixed(2) }}%</span>
                        <span class="ms-3 down h-25 px-2 py-1" v-else><i class="fa-solid fa-arrow-trend-down pe-1"></i>{{
                            this.tong_tien.toFixed(2) * -1 }}%</span>
                    </div>
                </div>

            </div>
        </div>
        <div class="">
            <h6 class="ps-3 pb-3">BIỂU ĐỒ THỐNG KÊ MÓN ĂN TIÊU BIỂU</h6>
            <div class="row ps-2 bieu-do">
                <Line v-if="this.data.datasets[0].data.length > 0" :data="data" :options="options" class="pt-3"
                    style="height: 53vh;" />
            </div>
        </div>
    </div>
</template>

<style scoped>
.title {
    box-shadow: 5px 1px 10px 0px grey;
}

.growth {
    background-color: rgb(45, 182, 45);
    color: white;
    /* padding: 0px 10px; */
    border-radius: 3px;
    box-shadow: 0 2px 2px 0px grey;
    font-size: 14px;
}

.down {
    background-color: rgb(225, 207, 41);
    color: white;
    /* padding: 0px 10px; */
    border-radius: 3px;
    box-shadow: 0 2px 2px 0px rgb(164, 160, 160);
    font-size: 14px;
}

.tong-quat {
    box-shadow: 1px 1px 4px 0px grey;
    border-radius: 3px;
    margin: 0 10px;
    max-width: 23%;
}

.bieu-do {
    box-shadow: 1px 1px 4px 0px grey;
    border-radius: 3px;
    margin-left: 15px;
    padding: 10px 5px;
    height: 58vh;
    max-width: 97%;
}

.active {
    border: 1px solid rgb(225, 207, 41) !important;
    color: rgb(225, 207, 41) !important;
    font-weight: bold;
}

.active:hover,
.active:active {
    background-color: rgb(225, 207, 41) !important;
    color: white !important;
    font-weight: bold;
}

.default {
    background-color: rgb(225, 207, 41);
    color: white;
    font-weight: bold;
}

.default:hover,
.default:active {
    border: 1px solid rgb(225, 207, 41) !important;
    color: rgb(225, 207, 41) !important;
    background-color: white !important;
    ;
    font-weight: bold;
}
</style>