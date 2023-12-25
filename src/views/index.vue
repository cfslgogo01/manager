<template>
  <div class="--el-box-shadow-light">
    <div class="common-layout">
      <el-container>
        <el-header style="text-align: right; background-color: rgb(247, 247, 247) ;" height="20px">
          <el-row class="row-bg" justify="space-between" :gutter="0">
            <el-col :span="1" :pull="0">
              <div style="position: absolute;left: 5px;">
                <el-button @click="onclick1" text style="padding: 0px; padding-left: 0px;
                margin: 0px;
                "><el-icon>
                    <Menu />
                  </el-icon>
                </el-button>
              </div>



            </el-col>

            <el-col :span="30">
              <div class="grid-content ep-bg-purple" style="position: absolute;right: 0px;">

                <div class="toolbar">

                  <el-text class="m" style="font-size: 19px" size="large">{{ 卡密激活用户管理系统 }}
                  </el-text>
                  <el-dropdown @command="下滑菜单触发" trigger="click" style="margin-left: 6px;">
                    <div class="index_drop_icon_button_">
                      <el-button link>
                        <el-icon style="margin: 0px;padding: 0px;  margin-top: 6px; margin-right: 0px" size="19px">
                          <MoreFilled />
                        </el-icon>
                      </el-button>
                    </div>


                    <template #dropdown>
                      <el-dropdown-menu>
                        <el-dropdown-item command="关于"><el-icon>
                            <Notification />
                          </el-icon>关于</el-dropdown-item>
                        <el-dropdown-item command="点赞"><el-icon>
                            <Star />
                          </el-icon>点赞</el-dropdown-item>
                        <el-dropdown-item command="留言"><el-icon>
                            <ChatRound />
                          </el-icon>留言
                        </el-dropdown-item>
                        <el-dropdown-item command="爱心" v-if="是否显示爱心">
                          <el-icon>
                            <svg t="1703159987563" class="icon" viewBox="0 0 1024 1024" version="1.1"
                              xmlns="http://www.w3.org/2000/svg" p-id="4242" width="" height="100%">
                              <path
                                d="M689.11 121.72c-70.21 0-133.67 28.85-179.2 75.32-45.53-46.48-108.99-75.32-179.2-75.32-138.56 0-250.89 112.32-250.89 250.87 0 286.73 430.08 537.6 430.08 537.6S940 659.33 940 372.6c0-138.55-112.32-250.88-250.89-250.88z"
                                fill="#EC87C0" p-id="4243"></path>
                              <path
                                d="M689.11 121.72c-12.17 0-24.12 0.88-35.83 2.56 121.58 17.39 215.04 121.93 215.04 248.31 0 235.84-290.97 447.42-394.25 515.1 22.29 14.61 35.84 22.51 35.84 22.51S940 659.33 940 372.6c0-138.55-112.32-250.88-250.89-250.88z"
                                fill="#FFFFFF" opacity=".2" p-id="4244"></path>
                            </svg>
                          </el-icon>爱心

                        </el-dropdown-item>

                      </el-dropdown-menu>
                    </template>
                  </el-dropdown>
                </div>
              </div>
            </el-col>
          </el-row>



        </el-header>
        <el-divider />
      </el-container>
    </div>

    <el-container class="layout-container-demo" style="height: 100%">
      <el-aside id="el-aside-setwidth" :width="width_aside" :style="{
        transition: `all 0.6s`,
      }">
        <el-scrollbar>
          <el-menu :unique-opened="true" :collapse="iscollapse && !_userAgent" @select="menuselect">
            <el-sub-menu index="1">
              <template #title>
                <el-icon>
                  <House />
                </el-icon>
                <span>Root</span>
              </template>

              <el-menu-item-group v-for="itemlinks in links.rootlinks" :key="itemlinks.label">
                <template #title>{{ itemlinks.label }}</template>
                <router-link v-for="link in itemlinks.links" :key="`/root${link.path}`" :to="`/root${link.path}`">
                  <el-menu-item :index="`/root+${link.path}`">
                    {{ link.name }}</el-menu-item>
                </router-link>
              </el-menu-item-group>
            </el-sub-menu>
            <el-sub-menu index="2">
              <template #title>
                <el-icon>
                  <User />
                </el-icon>
                <span>管理员</span>
              </template>

              <el-menu-item-group v-for="itemlinks in links.adminlinks" :key="itemlinks.label">
                <template #title>{{ itemlinks.label }}</template>
                <router-link v-for="link in itemlinks.links" :key="`/admin${link.path}`" :to="`/admin${link.path}`">
                  <el-menu-item :index="`/admin${link.path}`">
                    {{ link.name }}</el-menu-item>
                </router-link>
              </el-menu-item-group>
            </el-sub-menu>

            <el-sub-menu index="3">
              <template #title>
                <el-icon>
                  <Sugar />
                </el-icon>
                <span>用户</span>
              </template>

              <el-menu-item-group v-for="itemlinks in links.userlinks" :key="itemlinks.label">
                <template #title>{{ itemlinks.label }}</template>
                <router-link v-for="link in itemlinks.links" :key="`/user${link.path}`" :to="`/user${link.path}`">
                  <el-menu-item :index="`/user${link.path}`">
                    {{ link.name }}</el-menu-item>
                </router-link>
              </el-menu-item-group>
            </el-sub-menu>
          </el-menu>
        </el-scrollbar>
      </el-aside>

      <el-container>
        <el-main class="test3 " style="
        background-color: #fff;
        height: 80vh; 
        padding: 10%;
        padding-top: 0%;  
        margin-left: 1%;
        margin-right: 1%;
        padding-bottom: 0px;
        box-shadow: 0px 0px 12px rgba(0, 0, 0, 0.12);
">
          <div style=" 
          padding-left: 6%;
           padding-right: 6%;
            padding-top: 4%; 
            /* padding-bottom: 10%; */
">
            <RouterView></RouterView>
          </div>

        </el-main>
      </el-container>
    </el-container>
  </div>
</template>
  
<script  setup>
import myConfigs from "@/config/config.js";
const links = myConfigs.links;
console.log(links);
const _userAgent = /Mobile/i.test(navigator.userAgent);
import { ref } from "vue";
const 是否显示爱心 = ref(false)
const 卡密激活用户管理系统 = ref("卡密激活用户管理系统")
const iscollapse = ref(false);
iscollapse.value = iscollapse.value ^ !_userAgent
const onclick1 = () => {
  iscollapse.value = !iscollapse.value;

  if (iscollapse.value) {
    //小的
    if (_userAgent) {
      //手机
      width_aside.value = "0%";
    } else {
      width_aside.value = "0%vw";
    }
  } else {
    if (_userAgent) {
      //手机
      width_aside.value = "100%";
    } else {
      width_aside.value = "0%vw";
    }
  }
};
setTimeout(() => {
  onclick1();
}, 0);
const menuselect = (index, indexPath, routeResult) => {
  console.log("sdf", (index, indexPath, routeResult));
};
const width_aside = ref("0%");
const get_width_aside = () => {
  console.log(width_aside.value);
  return width_aside;
};
import { ElMessage, ElMessageBox } from 'element-plus'
import { markRaw } from 'vue'
import github from '@/components/icons/github.vue'
const 下滑菜单触发 = (mycommand) => {
  是否显示爱心.value = true
  console.log(mycommand);
  switch (mycommand) {
    case "关于": {
      ElMessage({
        message: 'activation-management system',
        type: 'success',
      })
      break;
    }
    case "点赞": {
      // ElMessageBox.confirm('Give this project a star on github!', '★ Star ★', {
      //   confirmButtonText: 'OK',
      //   callback: (action) => {
      //     ElMessage({
      //       type: 'info',
      //       message: `action: ${action}`,
      //     })
      //   },
      // })

      ElMessageBox.confirm(
        // 'Give this project a star on github!', '★ Star ★',
        'Give this project a star on github!', '轻倾初识语',
        {
          confirmButtonText: 'OK',
          cancelButtonText: 'Cancel',
          icon: (github),
          type: 'success',
        }
      )
        .then(() => {
          ElMessage({
            type: 'success',
            message: '谢谢，但是目前我们还没有开源~',
          })
        })
        .catch(() => {

        })
      break;
    }
    case "留言": {
      // ElMessage({
      //   type: 'success',
      //   message: '拾香淡绽时',
      // })
      ElMessage({
        type: 'success',
        message: '微信关注「沁与袅袅」',
      })
      // window.open('https://qm.qq.com/q/UhwXnsbrW2')
      break;
    }
    case "爱心": {
      卡密激活用户管理系统.value = "微信关注「沁与袅袅」"
      ElMessage({
        type: 'success',
        message: '微信关注「沁与袅袅」',
      })
      window.open('https://mp.weixin.qq.com/mp/qrcode?scene=10000004&size=102&__biz=MzkwNjU5NTE2Mg==&mid=2247484271&idx=1&sn=5d7be4dffbad9e70863e92fce4298dab&send_time=')
      break;
    }
  }
}
</script>
  
<style    >
.el-main {
  --el-main-padding: 0;
  padding: 0px;
  padding-top: 0;
  padding-left: 10px;
  padding-right: 5px;
}

.index_drop_icon_button_ .el-button.is-link {
  padding: 0px !important
}
</style>
  