<script>
import Menus from '@/components/Menu/Menu.vue';
import OrderItem from '../../components/Order/OrderItem.vue';
import DetailsItem from '../../components/DetailsBill/DetailsItem.vue';
import BillService from '@/services/bill.service';
import TableService from '@/services/table.service';
import UserService from '@/services/user.service';
import { useUserStore } from '@/stores/store';
import html2pdf from "html2pdf.js";
import { toast } from 'vue3-toastify';
import 'vue3-toastify/dist/index.css';


export default {
    components: {
        DetailsItem,
        Menus,
        OrderItem
    },
    data() {
        const acc = useUserStore();
        return {
            acc,
            dshd: [],
            dsb: [],
            dsnv: [],
            bill: {},
            selection: {},

        }

    },
    methods: {
        async getTable() {
            this.dsb = await TableService.getTable();
        },
        async getBillDay() {
            this.dshd = await BillService.getBillDay({ date: new Date().toLocaleString('vi-VN', { timeZone: 'Asia/Ho_Chi_Minh' }) });
        },
        async getUser() {
            this.dsnv = await UserService.getAll();
        },
        select(order) {
            this.selection = { ...order };
        },
        async change() {
            // await TableService.updateState(this.selection.so_ban, { trang_thai_ban_an: 'Hoàn thành' });
            // alert(`ĐÃ HOÀN THÀNH ĐƠN BÀN SỐ ${this.selection.so_ban}!!!`);
            toast(`ĐÃ HOÀN THÀNH ĐƠN BÀN SỐ ${this.selection.so_ban}!!!`, {
                autoClose: 3000,
                icon: false,
                position:'top-center',
                type: 'success',
                theme: 'colored'
            });
            this.selection = {};
        },
        async getTableBill(so_ban) {
            this.bill = await BillService.getBill(so_ban);
        },
        async confirmPayment() {
            await BillService.updateState(this.bill._id, { trang_thai_hoa_don: 'Đã thanh toán', so_ban: this.bill.so_ban });
            await TableService.updateState(this.bill.so_ban, { trang_thai_ban_an: 'Trống' });
            this.getTable();
            html2pdf(document.getElementById("bill"), {
                filename: `${this.bill._id}.pdf`,
                jsPDF: {
                    unit: 'in',
                    format: 'a5',
                    orientation: 'portrait'
                }
            });
        },
        logout() {
            setTimeout(() => { this.$router.push("/login"); }, 500);
            this.acc = {};
        }
    },
    created() {
        this.getUser();
        this.getTable();
        setInterval(() => { this.getTable(); }, 500);
    }

};

</script>

<template>
    <header class="position-sticky top-0">
        <h1>YL Food</h1>
        <div class="position-absolute d-flex align-items-center mb-2 text-end" style="right: 0; top: 18px">
            <div class="account">
                <img :src="`src/assets/images/${this.acc.user.hinh_anh_tai_khoan}`" class="rounded-5" alt="" width="40">

                <span class="text-light fw-bold fs-5 ms-2 me-3">{{ this.acc.user.ho_ten }}</span><i
                    class="fa-solid fa-right-from-bracket pe-3 fs-4 text-danger" data-bs-toggle="modal"
                    data-bs-target="#exampleModal1" style="cursor: pointer;"></i>
            </div>
        </div>
    </header>
    <main>
        <div class="modal fade hide " id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel1"
            aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-md modal-dialog-centered ">
                <div class="modal-content rounded-0">
                    <h5 class="modal-title text-center my-3" id="staticBackdropLabel">BẠN CÓ CHẮC CHẮN MUỐN ĐĂNG XUẤT?</h5>
                    <div class="modal-body text-center">
                        <i class="fa-regular fa-circle-xmark text-danger" style="font-size: 150px;"></i>
                    </div>
                    <div class="d-flex justify-content-center my-3">
                        <button @click="initData" type="button" class="btn btn-secondary rounded-0 px-3 py-2 me-1"
                            data-bs-dismiss="modal">Hủy</button>
                        <button type="button" data-bs-dismiss="modal" class="btn btn-danger rounded-0 px-3 py-2"
                            @click="this.logout()">Xóa</button>

                    </div>

                </div>
            </div>
        </div>
        <div class="row mt-3 mx-0">
            <div class="col-8 ">
                <div class="d-flex mt-3 justify-content-evenly">
                    <p><i class="fa-solid fa-circle me-1 empty"></i>Trống</p>
                    <p><i class="fa-solid fa-circle me-1 wait"></i>Đang Đợi Món</p>
                    <p><i class="fa-solid fa-circle me-1 wait-payment"></i>Đang Đợi Thanh Toán</p>
                    <p><i class="fa-solid fa-circle me-1 finish"></i>Hoàn Thành</p>
                </div>
                <div class="row justify-content-center table-col scroll">
                    <div class="ban-an col-3 d-flex me-2 mt-2" v-for="(e, i) in this.dsb" :key="i"
                        @click="getTableBill(e._id)">
                        <h4 v-if="e.trang_thai_ban_an === 'Trống'" class="col-12 text-light sb text-center py-5 rounded-2">
                            Bàn {{ e._id }}</h4>
                        <h4 v-else-if="e.trang_thai_ban_an === 'Đang chuẩn bị'"
                            class="col-12 text-light sb1 text-center py-5 rounded-2">Bàn {{ e._id }}</h4>
                        <h4 data-bs-toggle="modal" data-bs-target="#exampleModal"
                            v-else-if="e.trang_thai_ban_an === 'Đang đợi thanh toán'"
                            class="col-12 text-light sb3 text-center py-5 rounded-2">Bàn {{ e._id }}</h4>
                        <h4 v-else="e.trang_thai_ban_an === 'Hoàn thành'"
                            class="col-12 text-light sb2 text-center py-5 rounded-2">Bàn {{ e._id }}</h4>
                        <!-- <i class="fa-regular fa-square-minus fs-4 ms-1 text-danger" @click="this.delete(e._id)"></i> -->
                    </div>
                </div>
            </div>
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-md modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-body text-center">
                            <div class="d-flex justify-content-between">
                                <!-- <h5 class="modal-title" id="staticBackdropLabel">Xác Nhận Thanh Toán</h5> -->
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="details text-center my-3" id="bill">
                                <h6>Quán Ăn Hàn Quốc</h6>
                                <h3>YL Food</h3>
                                <p><i class="fa-solid fa-location-dot me-1"></i>Đường 3/2 - TP.Cần Thơ</p>
                                <p><i class="fa-solid fa-phone me-1"></i>0276455663</p>
                                <hr class="w-75 mx-auto border border-dark">
                                <h6 class="fw-bold">HÓA ĐƠN THANH TOÁN</h6>
                                <div class="d-flex justify-content-around mt-2">
                                    <span>Số HĐ: {{ this.bill._id }}</span>
                                    <span>Bàn: {{ this.bill.so_ban }}</span>
                                </div>
                                <div class="d-flex justify-content-around mt-2">
                                    <span><i class="fa-regular fa-calendar-days me-1"></i>{{ this.bill.thoi_gian }}</span>
                                    <span v-if="this.dsnv.length > 0 && this.bill._id != null">Nhân Viên: {{
                                        this.dsnv.filter(e => e._id == this.bill.ma_nhan_vien_xuat_don)[0].ho_ten }}</span>
                                </div>
                                <div class="d-flex mt-3 fw-bold">
                                    <span class="col-5">Tên Món</span>
                                    <span class="col-2">Số Lượng</span>
                                    <span class="col-2">Giá</span>
                                    <span class="col-3">Tổng Tiền</span>
                                </div>
                                <div class="d-flex mt-2" v-for="(e, i) in this.bill.danh_sach_mon_an" :key="i">
                                    <span class="col-5">{{ e.ten_mon_an }}</span>
                                    <span class="col-2">{{ e.so_luong }}</span>
                                    <span class="col-2">{{ e.gia_mon_an }}đ</span>
                                    <span class="col-3">{{ e.so_luong * e.gia_mon_an }}đ</span>
                                </div>
                                <hr>
                                <div class="d-flex mt-2 fw-bold">
                                    <span class="col-5">TỔNG CỘNG</span>
                                    <span class="col-2">{{ this.bill.tong_so_luong }}</span>
                                    <span class="col-2"></span>
                                    <span class="col-3">{{ new
                                        Intl.NumberFormat('vi-VN').format(this.bill.tong_tien / (1 -
                                            this.bill.gia_tri_giam_gia / 100))
                                    }}đ</span>
                                </div>
                                <div class="d-flex mt-2">
                                    <span class="col-5">GIẢM GIÁ</span>
                                    <span class="col-4"></span>
                                    <span class="col-3">{{ new Intl.NumberFormat('vi-VN').format((this.bill.gia_tri_giam_gia
                                        * this.bill.tong_tien / (1 - this.bill.gia_tri_giam_gia / 100)) / 100)
                                    }}đ</span>
                                </div>
                                <div class="d-flex mt-3 fw-bold">
                                    <h5 class="col-7">TỔNG TIỀN THANH TOÁN</h5>
                                    <span class="col-2"></span>
                                    <h5 class="col-3">{{ new Intl.NumberFormat('vi-VN').format(this.bill.tong_tien) }}đ</h5>
                                </div>
                                <h4 class="cam-on mt-5">CẢM ƠN QUÝ KHÁCH, HẸN GẶP LẠI!!!</h4>
                            </div>
                            <div class="text-end mt-5">
                                <button @click="confirmPayment" type="button" data-bs-dismiss="modal"
                                    class="btn btn-success rounded-0"><i class="fa-solid fa-floppy-disk me-2 fs-5"></i>Xác
                                    Nhận Thanh Toán</button>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="col-4 mt-3">
                <div class="text-end mb-3">
                    <button class="btn btn-success" @click="getBillDay" type="button" data-bs-toggle="collapse"
                        data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample"><i
                            class="fa-solid fa-coins fs-5 me-2" style="color: rgb(225, 207, 41)"></i>Kết Toán Trong
                        Ngày</button>
                </div>
                <div class="bill-day scroll collapse" id="collapseExample">
                    <span>Tổng Số: <b>{{ this.dshd.length }}</b></span>
                    <div class=" bill border rounded-2 p-2 mt-2 me-2" v-for="(e, i) in this.dshd" :key="i">
                        <div>
                            <div class="d-flex justify-content-between">
                                <p>Mã HD: {{ e._id }}</p>
                                <p><i class="fa-regular fa-calendar-days me-1"></i>{{ e.thoi_gian }}</p>
                            </div>
                            <div class="d-flex justify-content-between">
                                <p>Mã nhân viên: {{ e.ma_nhan_vien_xuat_don }}</p>
                                <p>Số Bàn: {{ e.so_ban }}</p>
                            </div>
                            <hr />
                            <div class="">
                                <p>Tổng Tiền Hóa Đơn: {{ new
                                    Intl.NumberFormat('vi-VN').format(e.tong_tien / (1 - e.gia_tri_giam_gia / 100)) }}đ</p>
                                <p>Tiền Giảm Giá: {{ new
                                    Intl.NumberFormat('vi-VN').format(e.tong_tien / (1 - e.gia_tri_giam_gia / 100) -
                                        e.tong_tien)
                                }}đ</p>
                                <p class="fw-bold">Tổng Tiền Thanh Toán: {{ new
                                    Intl.NumberFormat('vi-VN').format(e.tong_tien) }}đ</p>
                            </div>
                        </div>
                        <div class="tong-tien position-fixed bottom-0">
                            <h6 class="fw-bold">DOANH THU TRONG NGÀY:
                            </h6>
                            <div class="ps-3 mb-2">
                                <a>Tổng Tiền Hóa Đơn: </a><span class="text-danger">{{ new
                                    Intl.NumberFormat('vi-VN').format(this.dshd.reduce((sum, value) => sum +
                                        value.tong_tien / (1 - value.gia_tri_giam_gia / 100),
                                        0))
                                }}đ</span>
                            </div>
                            <div class="ps-3 mb-2">
                                <a>Tổng Tiền Giảm Giá: </a><span class="text-danger">{{ new
                                    Intl.NumberFormat('vi-VN').format(this.dshd.reduce((sum, value) => sum + (
                                        value.tong_tien / (1 - value.gia_tri_giam_gia / 100) -
                                        value.tong_tien),
                                        0))
                                }}đ</span>
                            </div>
                            <div class="ps-3">
                                <b>Tổng Tiền Nhận Từ Nhân Viên: </b><span class="text-danger fw-bold">{{ new
                                    Intl.NumberFormat('vi-VN').format(this.dshd.reduce((sum, value) => sum +
                                        value.tong_tien,
                                        0))
                                }}đ</span>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>

    </main>
</template>

<style scoped>
body {
    overflow: hidden;
}

header {
    background-color: rgb(225, 207, 41);
    color: white;
    font-style: italic;
    padding: 2px 0;
    text-align: center;
    z-index: 1000;
}

header h1 {
    font-family: 'Dancing Script', cursive !important;
    font-size: 50px;
    font-weight: 700;
}

.account {
    font-style: normal;
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

.ban-an {
    cursor: pointer;
}

.bill-day {
    max-height: 60vh;
    overflow-y: scroll;
    overflow-x: hidden;
}
.table-col {
    max-height: 80vh;
    overflow-y: scroll;
    overflow-x: hidden;
}

.bill {
    background-color: rgba(183, 181, 181, 0.251);

}

.scroll::-webkit-scrollbar {
    width: 5px;
}

.scroll::-webkit-scrollbar-track {
    background-color: rgba(214, 214, 214, 0.445);
    border-radius: 20px;
}

.scroll::-webkit-scrollbar-thumb {
    background-color: rgb(207, 205, 205);
    border-radius: 20px;
}

.details h3 {
    font-family: 'Dancing Script', cursive !important;
    font-size: 40px;
}

.cam-on {
    font-family: 'Dancing Script', cursive !important;
    font-size: 25px;
}
</style>