<script>
import Order from '@/components/Order/Order.vue'
import DetailsBill from '@/components/DetailsBill/DetailsBill.vue'
import Menus from '@/components/Menu/Menu.vue'

export default {
    components: {
        Order,
        DetailsBill,
        Menus
    },

};

</script>

<template>
    <header class="position-sticky top-0">
        <h1>KoreaFood</h1>
    </header>
    <main>
        <div class="row p-0 m-0">
            <div class="col-3 pe-0 mt-3">
                <h4>Đơn Đặt Món<i class="fa-solid fa-bell ms-2"></i></h4>
                <hr>
                <Order />
            </div>
            <div class="col-5 mt-3 pe-0 ">
                <div class="row justify-content-between">
                    <h4 class="col-6 m-0">Chi Tiết Đơn Đặt<i class="fa-regular fa-rectangle-list ms-2"></i></h4>
                    <span class="col-5 p-0 m-0">Được đặt bởi: Nguyễn Quốc Trạng</span>
                </div>
                <hr>
                <DetailsBill />
                <div class="row my-1 position-fixed " style="bottom:0; width: 41.6%;">
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





</style>