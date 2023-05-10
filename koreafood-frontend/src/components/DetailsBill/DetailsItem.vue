<script>
export default {
    data() {
        return {}
    },
    props: {
        order: { type: Object, default: {} }
    },
    methods: {

    }
}
</script>

<template>
    <div :class="`row align-items-center mb-3 ${order.trang_thai_mon_an==0? 'opacity':''}`" >
        <div class="img-box col-3 p-0">
            <img :src="'src/assets/images/' + order.hinh_anh_mon_an" alt="" width="150">
        </div>
        <div class="col-7">
            <p class="fw-bold m-0">{{ order.ten_mon_an }}</p>
            <p class="fst-italic m-0">( Ghi chú: {{ order.chu_thich }})</p>
        </div>
        <div class="col-2">
            <p>x{{ order.so_luong }}</p>
        </div>
        <!-- <div class="col-2 text-center hoan_thanh" @click="hiddenButton($event)">
                    <button class="btn btn-outline-success rounded-0">Xong</button>
                </div> -->
    </div>
</template>

<style>
.opacity{
    opacity: 0.3;
}
</style>