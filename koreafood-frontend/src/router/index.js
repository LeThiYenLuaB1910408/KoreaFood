import { createWebHistory, createRouter } from "vue-router";
import Home from '@/pages/Home/Home.vue';
import Login from '@/pages/Login/Login.vue';
import Accountant from '@/pages/Home/Accountant.vue';

const routes = [
    {
        path: '/',
        name: 'YL Food',
        component: Home,
    },
    {
        path: '/login',
        name: 'login',
        component: Login,
    },
    {
        path: '/accountant',
        name: 'accountant',
        component: Accountant,
    },
    {
        path: '/admin',
        component: ()=>import('@/components/layouts/AdminLayout.vue'),
        children: [
            {
                path:'',
                name:'dashboard',
                component: ()=> import('@/pages/Admin/DashBoard.vue')
            },
            {
                path:'/QLNV',
                name:'QLNV',
                component: ()=> import('@/pages/Admin/QLNV.vue')
            },
            {
                path:'/QLBA',
                name:'QLBA',
                component: ()=> import('@/pages/Admin/QLBA.vue')
            },
            {
                path:'/QLTD',
                name:'QLTD',
                component: ()=> import('@/pages/Admin/QLTD.vue')
            },
            {
                path:'/QLKM',
                name:'QLKM',
                component: ()=> import('@/pages/Admin/QLKM.vue')
            },
            {
                path:'/LSHD',
                name:'LSHD',
                component: ()=> import('@/pages/Admin/LSHD.vue')
            },
            {
                path:'/TKDT',
                name:'TKDT',
                component: ()=> import('@/pages/Admin/TKDT.vue')
            },
            {
                path:'/profile',
                name:'profile',
                component: ()=> import('@/pages/Admin/Profile.vue')
            },
        ]
    },
];

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes
});

export default router;