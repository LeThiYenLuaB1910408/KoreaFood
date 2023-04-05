<script>
import DetailsItem from './DetailsItem.vue'

export default {
    components: { DetailsItem }
}
</script>

<template>
    <div class="details-bill scroll">
        <DetailsItem 
        :imgItem="'src/assets/images/Do_An/com-tron.jpg'" 
        :nameItem="'Cơm Trộn Hàn Quốc'"
        :notes="'Siêu Cay'"
        :quantity="3"
        />
    </div>
</template>

<style>
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

.details-bill {
    max-height: 70%;
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