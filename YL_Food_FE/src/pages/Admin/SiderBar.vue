<script>
import { useUserStore } from '@/stores/store';
import 'vue3-toastify/dist/index.css';

export default {
    data() {
        const acc = useUserStore();
        return {
            acc
        }
    },
    methods: {
        logout() {
            setTimeout(() => { this.$router.push("/login"); }, 500)
            this.acc = {};
        }
    },
}
</script>

<template>
    <div class="col-3 container sidebar ps-4 position-sticky top-0">
        <h3>YL Food</h3>
        <hr class="text-light border border-1 border-light m-0">
        <nav class="mt-3">
            <ul>
                <router-link to="/admin">
                    <li><i class="fa-solid fa-cube me-2"></i>Tổng Quan</li>
                </router-link>
            </ul>

            <h6>MENU CHÍNH</h6>
            <ul>
                <router-link to="/QLNV">
                    <li><i class="fa-regular fa-user me-2"></i>Quản Lý Nhân Viên</li>
                </router-link>
                <router-link to="/QLBA">
                    <li><i class="fa-solid fa-table me-2"></i>Quản Lý Bàn Ăn</li>
                </router-link>
                <router-link to="/QLTD">
                    <li><i class="fa-solid fa-utensils me-2"></i>Quản Lý Thực Đơn</li>
                </router-link>
                <router-link to="/QLKM">
                    <li><i class="fa-solid fa-percent me-2"></i>Quản Lý Khuyến Mãi</li>
                </router-link>
                <router-link class="" data-bs-toggle="collapse" to="#collapseExample" role="button" aria-expanded="false"
                    aria-controls="collapseExample">
                    <li><i class="fa-solid fa-note-sticky me-2"></i>
                        Thống Kê<i class="fa-solid fa-caret-down ms-3"></i> </li>
                </router-link>
                <div class="collapse ms-5" id="collapseExample">
                    <ul>
                        <router-link to="/LSHD">
                            <li><i class="fa-solid fa-receipt me-2"></i>Lịch Sử Hóa
                                Đơn</li>
                        </router-link>
                        <router-link to="/TKDT">
                            <li><i class="fa-solid fa-money-bill me-2"></i>Thống Kê Doanh
                                Thu</li>
                        </router-link>
                    </ul>
                </div>

            </ul>
            <h6>LỰA CHỌN KHÁC</h6>
            <ul>
                <li><router-link to="#"><i class="fa-solid fa-question me-2"></i>Trợ Giúp</router-link></li>
                <li><router-link to="#"><i class="fa-solid fa-gear me-2"></i>Cài Đặt</router-link></li>
            </ul>
        </nav>

        <div class="btn-group dropend position-absolute d-flex align-items-center mb-2" style="bottom: 0;">
            <button class="btn dropdown-toggle account" data-bs-toggle="dropdown" aria-expanded="false">
                <img :src="`src/assets/images/${this.acc.user.hinh_anh_tai_khoan}`" class="rounded-5" alt="" width="40">
                <span class="text-light fw-bold fs-5 ms-2 me-3">{{ this.acc.user.ho_ten }}</span>
            </button>
            <ul class="dropdown-menu border-0 bg-light">
                <router-link class="dropdown-item text-dark" to="/profile">
                    <li>Xem Thông Tin Tài Khoản</li>
                </router-link>
                <li>
                    <hr class="dropdown-divider">
                </li>
                <li class="dropdown-item text-danger fw-bold" style="cursor: pointer;" @click="this.logout()">Đăng Xuất<i
                        class="fa-solid fa-right-from-bracket ms-2"></i></li>

            </ul>
        </div>
    </div>
</template>

<style scoped>
h3 {
    font-family: 'Dancing Script', cursive !important;
    font-size: 50px;
    font-weight: bold;
    color: white;
    text-align: center;
    margin-bottom: 0;
    padding: 5px 0;
}



h6 {
    font-size: 15px;
    color: rgb(125, 125, 125);
    font-weight: 700;
}

nav ul {
    list-style-type: none;
    padding-left: 0;
}

nav ul a {
    text-decoration: none;
    color: white;
    font-size: 20px;
}

nav ul li {
    padding: 10px 25px;
}

nav ul li:hover {
    background-color: rgb(209, 191, 24);
}

.sidebar {
    background-color: rgb(225, 207, 41);
    height: 100vh;
}

.account {
    border: none;
    border-radius: 5px;
    background-color: rgba(178, 177, 177, 0.393);
    cursor: pointer;
    color: white !important;
    padding: 15px 120px 10px 20px;
}

.dropdown-item:hover {
    background-color: rgba(178, 177, 177, 0.393);
}
</style>