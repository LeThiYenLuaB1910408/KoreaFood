<script>
import VueDatePicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';
import { ref } from 'vue';

export default {
    components: { VueDatePicker },
    data() {
        return {
            format: (date) => {
                const day = date.getDate();
                const month = date.getMonth() + 1;
                const year = date.getFullYear();
                return `${day}/${month}/${year}`;
            },
            date: ref({
                d: new Date()
            }),
            m: ref({
                mth: new Date().getMonth(),
                y: new Date().getFullYear(),
            }),
            year: ref({
                y: new Date().getFullYear()
            })

        }
    }
};
</script>

<template>
    <div class="title ps-4 py-3 mb-3">
        <h4 class="fw-bold">THỐNG KÊ DOANH THU</h4>
    </div>
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-6 d-flex">
                <div class="dropdown me-2">
                    <button class="btn btn-secondary dropdown-toggle rounded-0" type="button" id="dropdownMenuButton1"
                        data-bs-toggle="dropdown" aria-expanded="false">
                        Chọn Theo Ngày
                    </button>
                    <ul class="dropdown-menu rounded-0" aria-labelledby="dropdownMenuButton2">
                        <VueDatePicker v-model="date" :format="format"></VueDatePicker>
                    </ul>
                </div>
                <div class="dropdown me-2">
                    <button class="btn btn-secondary dropdown-toggle rounded-0" type="button" id="dropdownMenuButton2"
                        data-bs-toggle="dropdown" aria-expanded="false">
                        Chọn Theo Tháng
                    </button>
                    <ul class="dropdown-menu rounded-0" aria-labelledby="dropdownMenuButton2">
                        <VueDatePicker v-model="m" month-picker=true></VueDatePicker>
                    </ul>
                </div>
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle rounded-0" type="button" id="dropdownMenuButton3"
                        data-bs-toggle="dropdown" aria-expanded="false">
                        Chọn Theo Năm
                    </button>
                    <ul class="dropdown-menu rounded-0" aria-labelledby="dropdownMenuButton3">
                        <VueDatePicker v-model="year" year-picker=true></VueDatePicker>

                    </ul>
                </div>
            </div>
        </div>
        <div class="container">
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
                    <tr>
                        <th scope="row">1</th>
                        <td>Mỳ Cay Thập Cẩm</td>
                        <td>30</td>
                        <td>1,135,000đ</td>
                    </tr>
                    <tr>
                        <th scope="row">1</th>
                        <td>Mỳ Cay Thập Cẩm</td>
                        <td>30</td>
                        <td>1,135,000đ</td>
                    </tr>
                    <tr>
                        <th scope="row">1</th>
                        <td>Mỳ Cay Thập Cẩm</td>
                        <td>30</td>
                        <td>1,135,000đ</td>
                    </tr>
                    <tr>
                        <th scope="row">1</th>
                        <td>Mỳ Cay Thập Cẩm</td>
                        <td>30</td>
                        <td>1,135,000đ</td>
                    </tr>
                    <tr>
                        <th scope="row">1</th>
                        <td>Mỳ Cay Thập Cẩm</td>
                        <td>30</td>
                        <td>1,135,000đ</td>
                    </tr>
                </tbody>
            </table>
            <div class="doanhthu text-end">
                <h5>TỔNG DOANH THU: <b>12,000,000đ</b></h5>
            </div>
        </div>
    </div>
</template>

<style>
.title {
    box-shadow: 5px 1px 10px 0px grey;
}
</style>