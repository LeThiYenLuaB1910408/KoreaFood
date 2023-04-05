import { createApp } from 'vue'
import { createPinia } from 'pinia';
import App from './App.vue'
import "bootstrap/dist/css/bootstrap.min.css"; 
import "bootstrap/dist/js/bootstrap.bundle"; 
import "@fortawesome/fontawesome-free/css/all.min.css";
import router from './router';
const pinia = createPinia()

createApp(App).use(router).use(pinia).mount('#app')
