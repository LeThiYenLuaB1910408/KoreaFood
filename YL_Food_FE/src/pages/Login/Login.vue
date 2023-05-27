<script>
import UserService from "@/services/user.service.js";
import { useUserStore } from "@/stores/store";
import { toast } from 'vue3-toastify';
import 'vue3-toastify/dist/index.css';

export default {
    data() {
        const acc = useUserStore();
        return {
            username: '',
            password: '',
            acc,
            user: {}
        }
    },
    methods: {
        async login() {
            try {
                this.user = await UserService.login({ username: this.username, password: this.password });
                this.acc.user = this.user;
                if (this.user.tai_khoan != null && this.user.tai_khoan.cap_quyen == 1) {
                    toast("Đăng Nhập Trang Admin Thành Công", {
                        autoClose: 500,
                        type: 'success',
                        theme: 'colored'
                    });
                    setTimeout(() => { this.$router.push("/admin"); }, 1000);
                } else if (this.user.tai_khoan != null && this.user.tai_khoan.cap_quyen == 2) {
                    toast("Đăng Nhập Trang Thu Ngân Thành Công", {
                        autoClose: 500,
                        type: 'success',
                        theme: 'colored'
                    });
                    setTimeout(() => { this.$router.push("/accountant"); }, 1000);


                }
            } catch (error) {
                toast("Đăng Nhập Không Thành Công", {
                    autoClose: 1000,
                    type: 'error',
                    theme: 'colored'
                });

            }

        }
    }
}
</script>

<template>
    <div class="login">
        <div class="container title-login w-25 text-center mb-3">
            <img src="@/assets/logo.png" class="mb-3" alt="">
            <h3>Đăng Nhập YL Food</h3>
        </div>
        <form class="container main py-5" @submit.prevent="login">
            <div class="username mb-3">
                <p class="m-0 pb-2">Tên Đăng Nhập</p>
                <input type="text" placeholder="" class="border rounded-2 p-1" v-model="username" required>
            </div>

            <div class="password mb-3">
                <p class="m-0 pb-2">Mật Khẩu</p>
                <input type="password" placeholder="" class="border rounded-2 p-1" v-model="password" required>
            </div>
            <p v-if="this.user.message != null" class="text-danger">Tên Đăng Nhập hoặc Mật Khẩu không Hợp Lệ</p>
            <div class="sign-in mt-4">
                <button class="btn border rounded-2" type="submit">Đăng Nhập</button>
            </div>
        </form>
    </div>
</template>

<style scoped>
.login {
    padding: 80px 0;
}

h3 {
    font-family: 'Dancing Script', cursive;
    font-size: 40px;
    font-weight: bold;
    color: grey;
}

.btn {
    background-color: rgb(225, 207, 41) !important;
    color: white !important;
    font-weight: bold;
}

.btn,
input[type=text],
input[type=password] {
    outline: none;
    width: 100%;
}

input[type=text]:focus {
    border: 1px solid grey !important;
}

input[type=password]:focus {
    border: 1px solid grey !important;
}

.username {
    position: relative;
}

.username p {
    left: 0;
}

.main {
    min-height: 300px;
    width: 25%;
    border: 1px solid white;
    border-radius: 10px;
    box-shadow: 0px 0px 4px 1px grey;
}
</style>