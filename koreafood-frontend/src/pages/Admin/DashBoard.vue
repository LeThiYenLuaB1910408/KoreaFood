<script>
import { Bar, Line } from 'vue-chartjs'
import {
    Chart as ChartJS, Title, Tooltip, PointElement, Legend,
    LineElement, BarElement, CategoryScale, LinearScale
} from 'chart.js'
ChartJS.register(Tooltip, BarElement, CategoryScale, LinearScale, PointElement,
    LineElement, Title)
export default {
    name: 'BarChart',
    components: { Bar, Line },
    data() {
        return {
            data: {
                labels: ['Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Satur', 'Sun'],
                datasets: [
                    {
                        label: 'Doanh Thu',
                        backgroundColor: 'blue',
                        color: 'red',
                        data: [40, 39, 10, 40, 39, 80, 40],
                    },
                ],
            },
            chartData: {
                labels: ['Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Satur', 'Sun'],
                datasets: [
                    {
                        label: 'Doanh Thu',
                        backgroundColor: '#f87979',
                        data: [40, 20, 12]
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,

            }
        }
    }
}
</script>

<template>
    <div class="title ps-4 py-3 mb-3">
        <h4 class="fw-bold">TỔNG QUAN</h4>
    </div>
    <div class="container">
        <h6>TỔNG QUÁT</h6>
        <div class="row my-4 justify-content-center">
            <div class="col-3 tong-quat">
                <div class="justify-content-between d-flex">
                    <span class="text-secondary">Tổng Số Nhân Viên</span><i class="fa-regular fa-circle-user fs-3 mt-1"
                        style="color:blue"></i>
                </div>
                <div class="so-luong d-flex my-3">
                    <h4>20</h4>
                    <span class="ms-3 growth h-25 px-2 py-1"><i class="fa-solid fa-arrow-trend-up pe-1"></i>20.05%</span>
                </div>
            </div>
            <div class="col-3 tong-quat">
                <div class="justify-content-between d-flex">
                    <span class="text-secondary">Tổng Số Món Ăn</span><i class="fa-solid fa-plate-wheat fs-3 mt-1"
                        style="color:yellowgreen"></i>
                </div>
                <div class="so-luong d-flex my-3">
                    <h4>30</h4>
                    <span class="ms-3 growth h-25 px-2 py-1"><i class="fa-solid fa-arrow-trend-up pe-1"></i>20.05%</span>
                </div>
            </div>
            <div class="col-3 tong-quat">
                <div class="justify-content-between d-flex">
                    <span class="text-secondary">Tổng Số Hóa Đơn</span><i class="fa-solid fa-receipt fs-3 mt-1"
                        style="color:red"></i>
                </div>
                <div class="so-luong d-flex my-3">
                    <h4>150</h4>
                    <span class="ms-3 down h-25 px-2 py-1"><i class="fa-solid fa-arrow-trend-down pe-1"></i>20.05%</span>
                </div>
            </div>
            <div class="col-3 tong-quat">
                <div class="justify-content-between d-flex">
                    <span class="text-secondary">Tổng Doanh Thu</span><i class="fa-solid fa-coins fs-3 mt-1"
                        style="color: rgb(225, 207, 41)"></i>
                </div>
                <div class="so-luong d-flex my-3">
                    <h4>200,000,000<sup>đ</sup></h4>
                    <span class="ms-3 growth h-25 px-2 py-1"><i class="fa-solid fa-arrow-trend-up pe-1"></i>20.05%</span>
                </div>
            </div>

        </div>
    </div>
    <h6 class="ps-4">BIỂU ĐỒ DOANH THU</h6>
    <div class=" d-flex me-0">
        <div class="col-8 ps-4">
            <div class="container text-end">
                <button type="button" class="btn me-2 active">Tuần</button>
                <button type="button" class="btn default">Tháng</button>
            </div>
            <Line :data="data" :options="options" class="mt-3 h-75" />
        </div>
        <div class="col-4">
            <h6>BIỂU ĐỒ ĐƠN HÀNG THEO TUẦN</h6>
            <Bar :data="chartData" :options="options" />

            <h6>BIỂU ĐỒ ĐƠN HÀNG THEO THÁNG</h6>
            <Bar :data="chartData" :options="options" class="" />
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