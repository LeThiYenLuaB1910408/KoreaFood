<script>
import SiderBar from '@/pages/Admin/SiderBar.vue'

export default{
    components:{
        SiderBar
    }
}
</script>


<template>
    <div class="row m-0">
        <SiderBar />
        <div class="col-9 p-0">
            <RouterView />
        </div>
    </div>
</template>

<style>

</style>