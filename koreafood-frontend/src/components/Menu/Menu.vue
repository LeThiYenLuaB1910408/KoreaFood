<script>
import MenuItems from './MenuItem.vue'
import MenuService from '@/services/menu.service'

export default {
    components: { MenuItems },
    data() {
        return {
            ds: [],
            dstk: [],
            dsl: []
        }
    },
    methods: {
        async getData() {
            this.ds = await MenuService.getAll();
            this.dsl = this.ds.filter(e => e.id_loai_mon_an == 'L01');
            this.dstk = this.dsl;
        },
        getMenu(loai) {
            this.dsl = this.ds.filter(e => e.id_loai_mon_an == loai);
            this.dstk = this.dsl;
            if (loai == 'L01') {
                document.getElementsByClassName('btn-type')[0].classList.replace('active', 'default')
                document.getElementsByClassName('btn-type')[1].classList.replace('default', 'active')
            } else {
                document.getElementsByClassName('btn-type')[1].classList.replace('active', 'default')
                document.getElementsByClassName('btn-type')[0].classList.replace('default', 'active')

            }
        },
        search(event) {
            this.dstk = this.dsl.filter((e) => e.ten_mon_an.toLowerCase().includes(event.target.value.toLowerCase()));
        }
    },
    created() {
        this.getData();
    },
} 
</script>

<template>
    <div class="input-group mb-3 justify-content-center">
        <input @input="search($event)" type="text" placeholder="Tìm kiếm..." aria-label="Example text with button addon"
            aria-describedby="button-addon1">
    </div>
    <div class="row ms-3 mb-3">
        <button @click="getMenu('L01')" type="button" class="btn btn-type default col-2 me-2 rounded-5">Đồ Ăn</button>
        <button @click="getMenu('L02')" type="button" class="btn btn-type active col-3 rounded-5">Giải Khát</button>
    </div>
    <div v-if="this.dstk.length > 0" class="row ps-4 menu scroll">
        <div v-for="(e, i) in this.dstk" :key="i">
            <MenuItems :trang_thai_mon_an="e.trang_thai_mon_an" :id="e._id" :img="`src/assets/images/${e.hinh_anh_mon_an}`" :name="`${e.ten_mon_an}`" />
        </div>
    </div>
    <div v-else class="d-flex flex-column justify-content-center align-items-center" style="height: 100%;">
        <div class="mb-3"><i class="fa-regular fa-face-frown"
                style="font-size: 100px; color: rgb(155, 153, 153);"></i></div>
        <div><i class="fw-bold text-secondary">Không Tìm Thấy Kết Quả!!!</i></div>

    </div>
</template>

<style scoped>
.menu {
    max-height: 62vh;
    overflow-y: scroll;
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

.default {
    background-color: rgb(225, 207, 41) !important;
    border: 1px solid rgb(225, 207, 41) !important;
    color: white !important;
    font-weight: bold !important;
}

.active {
    border: 1px solid rgb(225, 207, 41) !important;
    color: rgb(225, 207, 41) !important;
    background-color: white !important;
    font-weight: bold !important;
}

input[type=text] {
    width: 95%;
    box-sizing: border-box;
    border: 2px solid #ccc;
    border-radius: 25px;
    font-size: 16px;
    background-color: white;
    background-image: url('@/assets/searchicon.png');
    background-position: 10px 10px;
    background-repeat: no-repeat;
    padding: 10px 20px 12px 40px;
    outline: none;
}

input[type=text]:focus {
    border: 1px solid grey;
}
</style>