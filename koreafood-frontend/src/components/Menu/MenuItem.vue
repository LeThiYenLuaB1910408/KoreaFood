<script>
import { Vue3ToggleButton } from 'vue3-toggle-button'
import { ref } from 'vue'
import MenuService from '@/services/menu.service';

export default {
    components: { Vue3ToggleButton, ref },
    data() {
        return {
            isActive: ref(this.trang_thai_mon_an == 1)
        }
    },
    props: {
        img: { type: String },
        name: { type: String },
        id: {type: String},
        trang_thai_mon_an: {type: Number}
    },
    methods: {
        async toggle() {
            this.isActive = !this.isActive;

            if(this.isActive){
                await MenuService.updateState(this.id, {trang_thai_mon_an: 1});
            }else{
                await MenuService.updateState(this.id, {trang_thai_mon_an: 0});
            }
        }
    }
}
</script>

<template>
    <div class="row align-items-center mb-3">
        <div class="col-3 p-0">
            <img :src="img" alt="" width="120" />
        </div>
        <div class="col-7 ps-4">
            <p class="fw-bold m-0">{{ name }}</p>
        </div>
        <div class="col-2">
            <Vue3ToggleButton :isActive="isActive" @onChange="toggle">
            </Vue3ToggleButton>
        </div>
    </div>
</template>

<style>
* {
    --6354bccb: 50px !important;
    --25183a7c: 25px !important;
    --623dbe68: #ccc;
    --384a0782: 1px;
    --e2e9258e: 34px;
    --7e99d065: 28px !important;
    --0dbc428b: rgb(225, 207, 41) !important;
    --2f8ce894: 50%;
    --7777ab42: rgb(231, 224, 168) !important;
    --c49c7066: 25px !important;

}
</style>