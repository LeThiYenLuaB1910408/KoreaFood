<script>
import VueDatePicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';
import { ref } from 'vue';
import MenuService from '@/services/menu.service';
import BillService from '@/services/bill.service';
import { Bar } from 'vue-chartjs';
import {
    Chart as ChartJS, Title, Tooltip, PointElement, Legend,
    LineElement, BarElement, CategoryScale, LinearScale
} from 'chart.js'
ChartJS.register(Tooltip, BarElement, CategoryScale, LinearScale, PointElement, Legend,
    LineElement, Title)

export default {
    components: { Bar },
    data() {
        return {
            ds: [],
            show: '',
            dshd: [],
            total: 0,
            dtnam: 2023,
            dtquy: {
                quy: 2,
                nam: 2023
            },
            dttuan: {
                ngay: 6,
                thang: 4,
                nam: 2023,
            },

            chartData: {
                labels: [],
                datasets: [
                    {
                        label: 'Tổng Doanh Thu',
                        backgroundColor: '#298ee1a8',
                        borderColor: '#298ee1f8',
                        data: []
                    }
                ]
            },
            chartData1: {
                labels: ['Tuần 1', 'Tuần 2', 'Tuần 3', 'Tuần 4', 'Tuần 5', 'Tuần 6', 'Tuần 7', 'Tuần 8', 'Tuần 9', 'Tuần 10', 'Tuần 11', 'Tuần 12'],
                datasets: [
                    {
                        label: 'Tổng Doanh Thu',
                        backgroundColor: '#298ee1a8',
                        borderColor: '#298ee1f8',
                        data: []
                    }
                ]
            },
            chartData2: {
                labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
                datasets: [
                    {
                        label: 'Tổng Doanh Thu',
                        backgroundColor: '#298ee1a8',
                        borderColor: '#298ee1f8',
                        data: []
                    }
                ]
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
                },

                animation: {
                    duration: 0
                },
                hover: {
                    animationDuration: 0 // duration of animations when hovering an item
                },
                responsiveAnimationDuration: 0

            }
        }
    },
    methods: {
        async getAll() {
            this.ds = (await MenuService.getAll()).filter((e) => e.so_luong_ban_ra > 5).sort(function (e1, e2) { return e2.so_luong_ban_ra - e1.so_luong_ban_ra });
            this.dshd = await BillService.getAll();
            this.total = this.dshd.reduce((sum, value) => sum + value.tong_tien, 0);

            let dtnam = new Array(12);
            for (let i = 0; i < 12; i++) {
                let sum = 0;
                this.dshd.forEach((e) => {
                    const day = e.thoi_gian.split(' ')[1].split('/');
                    if (day[2] == this.dtnam && day[1] == i + 1) {
                        sum += e.tong_tien
                    }
                })
                dtnam[i] = sum;
            }
            this.chartData2.datasets[0].data = [...dtnam];


            let dtquy = new Array(12);
            for (let i = 1; i <= 12; i++) {
                let sum = 0;
                this.dshd.forEach((e) => {
                    const day = e.thoi_gian.split(' ')[1].split('/');
                    if (day[2] == this.dtquy.nam) {
                        if (day[1] > (this.dtquy.quy - 1) * 3 && day[1] <= this.dtquy.quy * 3) {
                            day[1] = day[1] - 3 * (this.dtquy.quy - 1);
                            if (day[0] > (i - ((day[1] - 1) * 3 + day[1])) * 7 && day[0] <= ((i - ((day[1] - 1) * 3 + day[1])) + 1) * 7) {
                                sum += e.tong_tien
                            }
                        }
                    }
                })
                dtquy[i - 1] = sum;
            }
            this.chartData1.datasets[0].data = [...dtquy];

            let labelDay = { ...this.dttuan };
            let dttuan = new Array(7);
            for (let i = 0; i < 10; i++) {
                let sum = 0;
                this.dshd.forEach((e) => {
                    const day = e.thoi_gian.split(' ')[1].split('/');
                    if (day[2] == this.dttuan.nam && day[1] == this.dttuan.thang) {
                        if (day[0] - this.dttuan.ngay == i) {
                            sum += e.tong_tien;
                        }
                    }
                })
                dttuan[i] = sum;
                if (i > 0) {
                    labelDay.ngay += 1;
                }
                this.getNextDay(labelDay);
                this.chartData.labels.push(`${labelDay.ngay}/${labelDay.thang}/${labelDay.nam}`)
            }
            this.chartData.datasets[0].data = [...dttuan];
        },
        async getDtNam(count) {
            this.chartData2.datasets[0].data = []
            this.dtnam += count;
            this.dshd = await BillService.getAll();

            let dtnam = new Array(12);
            for (let i = 0; i < 12; i++) {
                let sum = 0;
                this.dshd.forEach((e) => {
                    const day = e.thoi_gian.split(' ')[1].split('/');
                    if (day[2] == this.dtnam && day[1] == i + 1) {
                        sum += e.tong_tien
                    }
                })
                dtnam[i] = sum;
            }
            this.chartData2.datasets[0].data = [...dtnam];
        },
        async getDtQuy(count) {
            this.chartData1.datasets[0].data = []
            this.dtquy.quy += count;
            if (this.dtquy.quy > 4) {
                this.dtquy.quy = 1;
                this.dtquy.nam += 1;

            } else
                if (this.dtquy.quy < 1) {
                    this.dtquy.quy = 4;
                    this.dtquy.nam -= 1;

                }
            this.dshd = await BillService.getAll();

            let dtquy = new Array(12);
            for (let i = 1; i <= 12; i++) {
                let sum = 0;
                this.dshd.forEach((e) => {
                    const day = e.thoi_gian.split(' ')[1].split('/');
                    if (day[2] == this.dtquy.nam) {
                        if (day[1] > (this.dtquy.quy - 1) * 3 && day[1] <= this.dtquy.quy * 3) {
                            day[1] = day[1] - 3 * (this.dtquy.quy - 1);
                            if (day[0] > (i - ((day[1] - 1) * 3 + day[1])) * 7 && day[0] <= ((i - ((day[1] - 1) * 3 + day[1])) + 1) * 7) {
                                sum += e.tong_tien
                            }
                        }
                    }
                })
                dtquy[i - 1] = sum;
            }
            this.chartData1.datasets[0].data = [...dtquy];
        },
        async getDtTuan(count) {
            this.chartData.datasets[0].data = [];
            this.chartData.labels = [];
            this.dttuan.ngay += count;
            this.getNextDay(this.dttuan);
            this.dshd = await BillService.getAll();

            let labelDay = { ...this.dttuan };
            let dttuan = new Array(7);
            for (let i = 0; i < 10; i++) {
                let sum = 0;
                this.dshd.forEach((e) => {
                    const day = e.thoi_gian.split(' ')[1].split('/');
                    if (day[2] == this.dttuan.nam && day[1] == this.dttuan.thang) {
                        if (day[0] - this.dttuan.ngay == i) {
                            sum += e.tong_tien;
                        }
                    }
                })
                dttuan[i] = sum;
                if (i > 0) {
                    labelDay.ngay += 1;
                }
                this.getNextDay(labelDay);
                this.chartData.labels.push(`${labelDay.ngay}/${labelDay.thang}/${labelDay.nam}`)
            }
            this.chartData.datasets[0].data = [...dttuan];
        },
        getNextDay(date) {
            switch (date.thang) {
                case 1:
                case 3:
                case 5:
                case 7:
                case 8:
                case 10:
                case 12:
                    if (date.ngay > 31) {
                        if (date.thang != 12) {
                            date.ngay = date.ngay - 31;
                            date.thang += 1;
                        } else {
                            date.ngay = date.ngay - 31;
                            date.thang = 1;
                            date.nam += 1;
                        }
                    } else if (date.ngay < 1) {
                        if (date.thang == 1) {
                            date.ngay = date.ngay + 31;
                            date.thang = 12;
                            date.nam -= 1;
                        } else if (date.thang == 3) {
                            date.ngay = date.ngay + 28;
                            date.thang -= 1;
                        } else if (date.thang == 8) {
                            date.ngay = date.ngay + 31;
                            date.thang -= 1;
                        } else {
                            date.ngay = date.ngay + 30;
                            date.thang -= 1;
                        }
                    }
                    break;
                case 4:
                case 6:
                case 9:
                case 11:
                    if (date.ngay > 30) {
                        date.ngay = date.ngay - 30;
                        date.thang += 1;
                    } else if (date.ngay < 1) {
                        date.ngay = date.ngay + 31;
                        date.thang -= 1;
                    }
                    break;
                case 2:
                    if (date.nam % 400 == 0 || (date.nam % 100 != 0 && date.nam % 4 == 0)) {
                        if (date.ngay > 29) {
                            date.ngay = date.ngay - 29;
                            date.thang += 1;
                        }
                    } else if (date.ngay > 28) {
                        date.ngay = date.ngay - 28;
                        date.thang += 1;
                    } else if (date.ngay < 1) {
                        date.ngay = date.ngay + 31;
                        date.thang -= 1;
                    }
                    break;

                default:
                    console.log('Không Hợp Lệ!!!');
                    break;
            }
        },

        eventChart(bieu_do) {
            this.show = bieu_do;
        }
    },
    mounted() {
        this.getAll();
    }
};
</script>

<template>
    <div class="title ps-4 py-3 mb-3">
        <h4 class="fw-bold">THỐNG KÊ DOANH THU</h4>
    </div>
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-9 d-flex">
                <div class=" me-2">
                    <button @click="eventChart('bieu-do-1')" class="btn btn-secondary rounded-0" type="button">
                        Thống Kê Trong Tuần
                    </button>
                </div>
                <div class=" me-2">
                    <button @click="eventChart('bieu-do-2')" class="btn btn-secondary rounded-0" type="button">
                        Thống Kê Trong Quý
                    </button>
                </div>
                <div class="">
                    <button @click="eventChart('bieu-do-3')" class="btn btn-secondary rounded-0" type="button">
                        Thống Kê Trong Năm
                    </button>
                </div>
            </div>
        </div>

        <div class="bieu-do" style="max-height: 75vh;">
            <div id="bieu-do-3" v-if="show == 'bieu-do-3'">
                <div class=" d-flex justify-content-end align-items-center">
                    <i class="fa-solid fa-angles-left btn btn-primary" @click="getDtNam(-1)"></i>
                    <p class="p-0 mb-0 mx-2">Năm <b>{{ this.dtnam }}</b> </p>
                    <i class="fa-solid fa-angles-right btn btn-primary" @click="getDtNam(1)"></i>

                </div>
                <Bar :data="chartData2" :options="options" class="pt-3"
                    v-if="this.chartData2.datasets[0].data.length != 0" />
            </div>
            <div v-if="show == 'bieu-do-2'">
                <div class=" d-flex justify-content-end align-items-center">
                    <i class="fa-solid fa-angles-left btn btn-primary" @click="getDtQuy(-1)"></i>
                    <p class="p-0 mb-0 mx-2">Quý <b>{{ this.dtquy.quy }}</b> Năm <b>{{ this.dtquy.nam }}</b> </p>
                    <i class="fa-solid fa-angles-right btn btn-primary" @click="getDtQuy(1)"></i>

                </div>
                <Bar :data="chartData1" :options="options" class="pt-3"
                    v-if="this.chartData1.datasets[0].data.length != 0" />
            </div>
            <div v-if="show == 'bieu-do-1'">
                <div class=" d-flex justify-content-end align-items-center">
                    <i class="fa-solid fa-angles-left btn btn-primary me-2" @click="getDtTuan(-10)"></i>

                    <i class="fa-solid fa-angles-right btn btn-primary" @click="getDtTuan(10)"></i>

                </div>
                <Bar :data="chartData" :options="options" class="pt-3" v-if="this.chartData.datasets[0].data.length != 0" />
            </div>
        </div>
        <div class="container mt-5">
            <h5 class="">Danh Sách Món Ăn Bán Chạy</h5>
            <table class="table table-hover text-center mt-3">
                <thead>
                    <tr>
                        <th scope="col">STT</th>
                        <th scope="col">Tên Món</th>
                        <th scope="col">Số Lượng/Phần Đã Bán</th>
                        <th scope="col">Tổng Tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(e, i) in this.ds" :key="i">
                        <th scope="row">{{ i + 1 }}</th>
                        <td>{{ e.ten_mon_an }}</td>
                        <td>{{ e.so_luong_ban_ra }}</td>
                        <td>{{ new Intl.NumberFormat('vi-VN').format(e.so_luong_ban_ra * e.gia_mon_an) }}đ</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</template>

<style>
.title {
    box-shadow: 5px 1px 10px 0px grey;
}

.fa-solid {
    cursor: pointer;
}
</style>