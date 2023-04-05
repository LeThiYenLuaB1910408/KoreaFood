<script>
import OrderItem from './OrderItem.vue'

export default{
    components:{OrderItem},
    data(){
        return {tableNumber:'5'}
    }
}
</script>

<template> 
    <div class="order scroll">
        <OrderItem :tableNumber="tableNumber"/>
    </div>
</template>

<style>
.order {
    max-height: 75%;
    overflow-y: scroll;
    overflow-x: hidden;
}

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
}

.notify:focus {
    background-color: rgb(179, 177, 177);
}
</style>