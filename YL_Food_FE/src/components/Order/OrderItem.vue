<script>
import OrderService from '@/services/order.service';

export default{
    props:{
        order:{type: Object, default: {}}
    },
    data(){
        return {
            now: (new Date()).getHours()
        }
    },
    methods:{
        async change(){
            this.order.da_xem = true;
            await OrderService.updateState(this.order);
            this.$emit("select:order", this.order);
        }
    },
    emits:["select:order"]
}
</script>

<template>
    <div class="notify row border rounded-2 p-2 mx-1 mb-3" @click="change">
            <div class="col-2 avatar text-center rounded-circle text-white fs-5 position-relative">
                {{ order.so_ban }}
                <span v-show="order.da_xem == false" class="dot position-absolute translate-middle p-2 bg-danger border border-light rounded-circle">
                </span>
            </div>
            <div class="col-9 ms-2">
                <p class="p-0 m-0 fw-bold fs-5">Đơn Đặt Từ Bàn Số {{ order.so_ban }}</p>
                <p class="p-0 m-0">{{ order.thoi_gian }}</p>
            </div>
        </div>
</template>

<style>
.avatar {
    background-color: rgb(225, 207, 41);
    padding-top: 10px;
}

.dot {
    top: 8px;
    right: -10px;
}

.notify:hover {
    background-color: rgb(238, 237, 237);
    cursor: pointer;
}

.notify:focus {
    background-color: rgb(179, 177, 177);
}
.img-box {
    width: 130px;
    max-height: 130px;
    box-sizing: border-box;
    overflow: hidden;
    position: relative;
}

.img-box img {
    object-fit: cover;
    display: block;
    width: 100%;
    opacity: 0.9;
    z-index: 1;
}

</style>