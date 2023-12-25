import myconfig from '@/config/config';

import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '@/views/HomeView.vue';
import NotFound from '@/views/NotFound.vue';

import root_agreeInitiation from '@/views/root/agreeInitiation.vue';
import root_createAdmin from '@/views/root/createAdmin.vue';
import root_decideChange from '@/views/root/decideChange.vue';
import root_generateCode from '@/views/root/generateCode.vue';
import root_queryAdminLogs from '@/views/root/queryAdminLogs.vue';
import root_queryUserActivation from '@/views/root/queryUserActivation.vue';
import root_queryUserLogs from '@/views/root/queryUserLogs.vue';
import root_queryFuncStatus from '@/views/root/queryFuncStatus.vue';


import admin_agreeInitiation from '@/views/admin/agreeInitiation.vue';
import admin_generateCode from '@/views/admin/generateCode.vue';
import admin_initiateChange from '@/views/admin/initiateChange.vue';
import admin_queryAdminLogs from '@/views/admin/queryAdminLogs.vue';
import admin_queryUserActivation from '@/views/admin/queryUserActivation.vue';
import admin_queryUserLogs from '@/views/admin/queryUserLogs.vue';
import admin_queryFuncStatus from '@/views/admin/queryFuncStatus.vue';

import user_activateFunc from '@/views/user/activateFunc.vue';
import user_queryMyActivation from '@/views/user/queryMyActivation.vue';
import user_queryMyLogs from '@/views/user/queryMyLogs.vue';
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/login',
      name: 'login',
      component: HomeView
    },
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/root',
      name: 'root',
      children: [
        { path: 'agreeInitiation', component: root_agreeInitiation },
        { path: 'createAdmin', component: root_createAdmin },
        { path: 'decideChange', component: root_decideChange },
        { path: 'generateCode', component: root_generateCode },
        { path: 'queryAdminLogs', component: root_queryAdminLogs },
        { path: 'queryUserActivation', component: root_queryUserActivation },
        { path: 'queryUserLogs', component: root_queryUserLogs },
        { path: 'queryFuncStatus', component: root_queryFuncStatus },
      ]
    },
    {
      path: '/admin',
      name: 'admin',
      children: [
        { path: 'agreeInitiation', component: admin_agreeInitiation },
        { path: 'generateCode', component: admin_generateCode },
        { path: 'initiateChange', component: admin_initiateChange },
        { path: 'queryAdminLogs', component: admin_queryAdminLogs },
        { path: 'queryUserActivation', component: admin_queryUserActivation },
        { path: 'queryUserLogs', component: admin_queryUserLogs },
        { path: 'queryFuncStatus', component: admin_queryFuncStatus },
      ]
    },
    {
      path: '/user',
      name: 'user',
      children: [
        { path: 'activateFunc', component: user_activateFunc },
        { path: 'queryMyActivation', component: user_queryMyActivation },
        { path: 'queryMyLogs', component: user_queryMyLogs },
        { path: 'queryAdminLogs', component: admin_queryAdminLogs },
        { path: 'queryUserActivation', component: admin_queryUserActivation },
        { path: 'queryUserLogs', component: admin_queryUserLogs },
      ]
    },
    { path: '/:catchAll(.*)', component: NotFound }
  ]
})

router.beforeEach((to, from, next) => {
  
  if (to.path == '/login') {
    next();

  } else {
    if (myconfig.检查状态信息()) {
      next();
    } else {
      next({ path: '/login' });
    }
  }


})
export default router
