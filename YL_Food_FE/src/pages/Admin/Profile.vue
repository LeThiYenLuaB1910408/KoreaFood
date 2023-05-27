<script>
import UserService from '@/services/user.service';
import { useUserStore } from "@/stores/store";
import { toast } from 'vue3-toastify';
import 'vue3-toastify/dist/index.css';

export default {
    data() {
        const acc = useUserStore();
        return {
            acc,
            file: null,
            user: {},
            password: {},
            url: null
        }
    },
    methods: {
        show(inputid, event) {
            const ipnElement = document.getElementById(inputid);
            const currentType = ipnElement.getAttribute('type')
            ipnElement.setAttribute(
                'type',
                currentType === 'password' ? 'text' : 'password'
            );
            event.srcElement.classList.toggle("text-danger");
            event.srcElement.classList.toggle("text-success");
            event.srcElement.innerHTML = (currentType === 'password' ? 'Ẩn' : 'Hiện');
        },
        call() {
            document.getElementById("avar").addEventListener("click");
        },
        changeFile(event) {
            this.file = event.target.files[0];
            this.url = URL.createObjectURL(this.file);
        },
        async updateAvar() {
            const formData = new FormData();
            formData.append('file', this.file);
            await UserService.updateAvar(formData, this.acc.user._id);
            this.file = null;
            toast("Cập Nhật Thành Công", {
                autoClose: 1000,
                type: 'success',
                theme: 'colored'
            });
            this.getUser();
        },
        async getUser() {
            this.user = await UserService.getUser(this.acc.user._id);
            this.acc.user = this.user;
        },
        async updatePassword() {
            if (this.password.new != this.password.newconFirm) {
                toast("Mật Khẩu Không Trùng Khớp", {
                    autoClose: 2000,
                    type: 'error',
                    theme: 'colored'
                });
            } else {
                const result = await UserService.updatePassword(this.acc.user._id, this.password);
                if (result.message == 'Mật Khẩu Không Đúng!!!') {
                    toast(result.message, {
                        autoClose: 1000,
                        type: 'error',
                        theme: 'colored'
                    });
                }else{
                    toast(result.message, {
                        autoClose: 1000,
                        type: 'success',
                        theme: 'colored'
                    });
                }

            }
        },
        async updateProfile() {
            const rs = await UserService.updateProfile(this.user);
            toast("Cập Nhật Thành Công", {
                autoClose: 1000,
                type: 'success',
                theme: 'colored'
            });
            this.getUser();
        }
    },
    created() {
        this.getUser();
    }
}
</script>

<template>
    <div class="title ps-4 py-3 mb-3">
        <h4 class="fw-bold">THÔNG TIN TÀI KHOẢN</h4>
    </div>
    <div class="container mt-5 border w-50">
        <div class="d-flex justify-content-center">
            <div class="d-flex align-items-end">
                <div class="rounded-circle" style="width: 200px; height: 200px; overflow: hidden;">
                    <img :src="`src/assets/images/${this.user.hinh_anh_tai_khoan}`" alt="" style="width: 100%;">
                </div>
                <div class="d-flex">
                    <h4>{{ this.user.ho_ten }}</h4>
                    <div class="dropup">
                        <button class="btn dropdown-toggle border-0" id="dropdownMenuButton1" data-bs-toggle="dropdown"
                            aria-expanded="false">
                            <i class="fa-solid fa-pen-to-square fs-5"></i>
                        </button>
                        <ul class="dropdown-menu rounded-0" aria-labelledby="dropdownMenuButton1">
                            <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#exampleModal">Đổi
                                    Ảnh Đại Diện</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="#" data-bs-toggle="modal"
                                    data-bs-target="#exampleModal1">Chỉnh Sửa Thông Tin Cá Nhân</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#exampleModal2">Đổi
                                    Mật Khẩu Tài Khoản</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-md modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="staticBackdropLabel">Đổi Ảnh Đại Diện</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body d-flex justify-content-center">
                        <label v-if="this.file == null" @click="call" for="avar" id="change"
                            class="form-label fw-bold avar">+ Chọn Ảnh</label>
                        <div v-else class="text-center">
                            <div class="rounded-circle text-center" style="width: 200px; height: 200px; overflow: hidden;">
                                <img v-if="this.url != null" :src="this.url" alt="" style="width: 100%;">
                            </div>
                            <label id="change" for="avar" class="form-label fw-bold avar mt-3">{{ this.file.name }}</label>
                        </div>
                        <div class="row m-3" style="display: none;">
                            <input type="file" @change="changeFile($event)" class="form-control border rounded-0" id="avar"
                                name="avar" accept="image/png, image/gif, image/jpeg" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button @click="updateAvar" type="button" data-bs-dismiss="modal"
                            class="btn btn-primary rounded-0">Cập Nhật</button>

                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="staticBackdropLabel">Thay Đổi Thông Tin Cá Nhân</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-5 mb-3 mt-3">
                                <label for="ht" class="form-label">Họ Và Tên</label>
                                <input v-model="this.user.ho_ten" type="text" class="form-control border rounded-0" id="ht"
                                    name="ht" />
                            </div>
                            <div class="col-md-4 mb-3 mt-3">
                                <label for="sdt" class="form-label">Số điện thoại:</label>
                                <input v-model="this.user.so_dien_thoai" type="text" class="form-control border rounded-0"
                                    id="sdt" name="sdt" />
                            </div>
                            <div class=" col-md-3 mb-3 mt-3">
                                <label for="gt" class="form-label">Giới Tính</label>
                                <select v-model="this.user.gioi_tinh" id="inputState" class="form-select">
                                    <option selected>- Chọn -</option>
                                    <option value="Nam">Nam</option>
                                    <option value="Nữ">Nữ</option>
                                </select>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-7 mb-3 mt-3">
                                <label for="dc" class="form-label">Địa Chỉ:</label>
                                <input v-model="this.user.dia_chi" type="text" class="form-control border rounded-0" id="dc"
                                    name="dc" />
                            </div>
                            <div class="col-md-5 my-3">
                                <label for="ns" class="form-label">Ngày Sinh:</label>
                                <input v-model="this.user.ngay_sinh" type="date" class="form-control border rounded-0"
                                    id="ns" name="ns" />
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary rounded-0" data-bs-dismiss="modal">Đóng</button>
                        <button @click="updateProfile" type="button" data-bs-dismiss="modal" aria-label="Close"
                            class="btn btn-primary rounded-0">Lưu</button>

                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-md modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="staticBackdropLabel">Đổi Mật Khẩu</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <label for="password1" class="form-label">Mật Khẩu Cũ:</label>
                        <div class="row">
                            <div class="col-11 my-3">
                                <input v-model="this.password.old" type="password" class="form-control border rounded-0"
                                    id="password1" name="password1" />
                            </div>
                            <div class="col-1 my-4 p-0"><button class="btn fw-bold p-0 border-0 text-success"
                                    @click="show('password1', $event)">Hiện</button></div>
                        </div>
                        <label for="password2" class="form-label">Mật Khẩu Mới:</label>
                        <div class="row">
                            <div class="col-11 my-3">
                                <input v-model="this.password.new" type="password" class="form-control border rounded-0"
                                    id="password2" name="password2" />
                            </div>
                            <div class="col-1 my-4 p-0"><button class="btn fw-bold p-0 border-0 text-success"
                                    @click="show('password2', $event)">Hiện</button></div>
                        </div>
                        <label for="password3" class="form-label">Xác Nhận Mật Khẩu Mới:</label>
                        <div class="row">
                            <div class="col-11 my-3">
                                <input v-model="this.password.newconFirm" type="password"
                                    class="form-control border rounded-0" id="password3" name="password3" />
                            </div>
                            <div class="col-1 my-4 p-0"><button class="btn fw-bold p-0 border-0 text-success"
                                    @click="show('password3', $event)">Hiện</button></div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary rounded-0" data-bs-dismiss="modal">Đóng</button>
                        <button @click="updatePassword" type="button" class="btn btn-primary rounded-0">Lưu</button>

                    </div>
                </div>
            </div>
        </div>

        <div class="d-flex justify-content-center">
            <div class="d-flex mt-5">
                <span class="fw-bold text-secondary ps-2">THÔNG TIN CÁ NHÂN</span>
                <div class="infor ps-3">
                    <ul style="list-style-type:none">
                        <li class="pb-2">Họ Và Tên: {{ this.user.ho_ten }}</li>
                        <li class="pb-2">Giới Tính: {{ this.user.gioi_tinh }}</li>
                        <li class="pb-2"><i class="fa-solid fa-cake-candles pe-2"></i> {{ this.user.ngay_sinh }}</li>
                        <li class="pb-2"><i class="fa-solid fa-phone-volume pe-2"></i> {{ this.user.so_dien_thoai }}
                        </li>
                        <li class="pb-2"><i class="fa-solid fa-location-dot pe-2"></i> {{ this.user.dia_chi }}</li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="d-flex justify-content-center">
            <div class="d-flex mt-5">
                <span class="fw-bold text-secondary">THÔNG TIN TÀI KHOẢN</span>
                <div class="acc ps-2">
                    <ul style="list-style-type:none">
                        <li class="pb-2">Vị Trí: Chủ Quán</li>
                        <li class="pb-2">Tên Tài Khoản: {{ this.acc.user.tai_khoan.ten_dang_nhap }}</li>
                        <li class="pb-2">Mật Khẩu: ********</li>
                    </ul>
                </div>
            </div>
        </div>

    </div>
</template>

<style scoped>
.title {
    box-shadow: 5px 1px 10px 0px grey;
}

h5 {
    align-content: end;
}

.container {
    background-color: rgb(232, 232, 232);
    border-radius: 10px;
    box-shadow: 1px 0px 5px 0px grey;
    padding: 15px 0;
}

.eye2 {
    visibility: hidden;
}

.avar {
    cursor: pointer;
    padding: 10px 50px;
    width: 100%;
    text-align: center;
    border-radius: 10px;
    background-color: rgba(0, 153, 255, 0.197);
    color: rgb(0, 102, 255);
}
</style>