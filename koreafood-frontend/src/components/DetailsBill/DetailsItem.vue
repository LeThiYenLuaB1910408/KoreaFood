<script>
export default{
    data(){
        return{}
    },
    props:{
        imgItem: {type: String},
        nameItem: {type:String},
        notes: {type:String},
        quantity: {type: Number}
    }
}
</script>

<template>
    <div class="row align-items-center mb-3">
            <div class="img-box col-3 p-0">
                <img :src="imgItem" alt="" width="150">
            </div>
            <div class="col-5">
                <p class="fw-bold m-0">{{nameItem}}</p>
                <p class="fst-italic m-0">( Ghi chú: {{notes}})</p>
            </div>
            <div class="col-2">
                <p>x{{quantity}}</p>
            </div>
            <div class="col-2 text-center">
                <button class="btn btn-outline-success rounded-0">Xong</button>
            </div>
        </div>
</template>

<style></style>