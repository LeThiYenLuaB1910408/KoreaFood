<script>
export default{
    props:{
        tableNumber:{type: String, default: ''}
    },
    data(){
        return {
            now: (new Date()).getHours()
        }
    }
}
</script>

<template>
    <div class="notify row border rounded-2 p-2 mx-1 mb-3">
            <div class="col-2 avatar text-center rounded-circle text-white fs-5 position-relative">
                {{ tableNumber }}
                <span class="dot position-absolute translate-middle p-2 bg-danger border border-light rounded-circle">
                    <span class="visually-hidden">New alerts</span>
                </span>
            </div>
            <div class="col-9 ms-2">
                <p class="p-0 m-0 fw-bold fs-5">Đơn Đặt Từ Bàn Số {{ tableNumber }}</p>
                <p class="p-0 m-0">{{ now }}h trước</p>
            </div>
        </div>
</template>

<style></style>