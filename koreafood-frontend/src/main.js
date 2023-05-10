import { createApp } from 'vue'
import { createPinia } from 'pinia';
import App from './App.vue'
import "bootstrap/dist/css/bootstrap.min.css"; 
import "bootstrap/dist/js/bootstrap.bundle"; 
import "@fortawesome/fontawesome-free/css/all.min.css";
import router from './router';
import Vue3Toastify from 'vue3-toastify';
import VueSocketIO from 'vue-socket.io'
const pinia = createPinia()


createApp(App).use(router).use(pinia).use(Vue3Toastify, {
    autoClose: 3000,
  } ).mount('#app')
