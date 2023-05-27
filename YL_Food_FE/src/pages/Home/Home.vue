<script>
import Menus from '@/components/Menu/Menu.vue';
import OrderItem from '../../components/Order/OrderItem.vue';
import DetailsItem from '../../components/DetailsBill/DetailsItem.vue';
import OrderService from '@/services/order.service';
import UserService from '@/services/user.service';
import { socket } from "@/socket";
import { toast } from 'vue3-toastify';
import 'vue3-toastify/dist/index.css';

export default {
    components: {
        DetailsItem,
        Menus,
        OrderItem
    },
    data() {
        return {
            ds: [],
            dsnv: [],
            selection: {}
        }
    },
    methods: {
        async getOrder() {
            this.ds = (await OrderService.getAll()).reverse();

        },
        async getUser() {
            this.dsnv = await UserService.getAll();
        },
        select(order) {
            this.selection = { ...order };
        },
        async change() {
            this.selection.danh_sach_mon_an.forEach((e) => e.trang_thai_mon_an = 0);
            await OrderService.successOrder(this.selection.so_ban, this.selection);
            socket.emit("successOrder", this.selection.so_ban, () => { });
            toast(`ĐÃ HOÀN THÀNH ĐƠN BÀN SỐ ${this.selection.so_ban}!!!`, {
                autoClose: 1000,
                type: 'success',
                theme: 'colored'
            });
            this.selection = {};
        },
        connect() {
            socket.connect();
        },

    },
    created() {
        this.connect();
        this.getOrder();
        this.getUser();
        socket.on('sendOrderWeb', (so_ban) => {
            toast(`CÓ ĐƠN MỚI BÀN SỐ ${so_ban}`, {
                autoClose: 5000,
                icon: false,
                position:'top-left'
            });
            this.getOrder();
        });
        socket.on('updateOrderWeb', (so_ban) => {
            if(so_ban){
                toast(`ĐƠN BÀN SỐ ${so_ban} VỪA ĐƯỢC THAY ĐỔI`, {
                    autoClose: 5000,
                    icon: false,
                    position:'top-left'
                });
            }
            this.getOrder();
        });
        socket.on('deleteOrderWeb', (so_ban) => {
            toast(`ĐƠN BÀN SỐ ${so_ban} VỪA ĐƯỢC HỦY`, {
                autoClose: 5000,
                icon: false,
                position:'top-left'
            });
            this.getOrder();
        });
    }

};

</script>

<template>
    <header class="position-sticky top-0">
        <h1>YL Food</h1>
    </header>
    <main>
        <div class="row p-0 m-0">
            <div class="col-3 pe-0 mt-3">
                <h4>Đơn Đặt Món<i class="fa-solid fa-bell ms-2"></i></h4>
                <hr>
                <div class="order scroll">
                    <OrderItem v-for="(e, i) in this.ds" :key="i" :order="e" @select:order="select" />
                </div>
            </div>
            <div class="col-5 mt-3 pe-0 ">
                <div class="row justify-content-between">
                    <h4 class="col-8 m-0">Chi Tiết Đơn Đặt Bàn {{ this.selection.so_ban }}<i
                            class="fa-regular fa-rectangle-list ms-2"></i></h4>
                    <span class="col-4 p-0 m-0">Được đặt bởi: {{ this.selection.ma_nhan_vien_lap_don }}</span>
                </div>
                <hr>
                <div class="details-bill scroll">
                    <DetailsItem v-for="(e, i) in this.selection.danh_sach_mon_an" :order="e" />
                </div>
                <div v-show="this.selection.so_ban != null" @click="change" class="row my-1 position-fixed "
                    style="bottom:0; width: 41.6%;">
                    <div class="btn btn-success rounded-0 fs-5">Hoàn Thành</div>
                </div>
            </div>
            <div class="col-4 mt-3">
                <h4>Danh Sách Món Ăn<i class="fa-solid fa-utensils ms-2"></i></h4>
                <hr>

                <Menus />
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

.order {
    max-height: 75vh;
    overflow-y: scroll;
    overflow-x: hidden;
}


.details-bill {
    max-height: 70vh;
    overflow-y: scroll;
    overflow-x: hidden;
}

.scroll::-webkit-scrollbar {
    width: 10px;
}

.scroll::-webkit-scrollbar-track {
    background-color: rgba(214, 214, 214, 0.445);
    border-radius: 20px;
}

.scroll::-webkit-scrollbar-thumb {
    background-color: rgb(207, 205, 205);
    border-radius: 20px;
}
</style>