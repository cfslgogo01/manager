<template>
  <!-- <div>欢迎使用~</div> -->

  <div>

    <el-form :model="账号.data" status-icon label-width="120px">
      <el-form-item label="账号:" prop="num">
        <el-input v-model="账号.data.num" type="" autocomplete="off" />
      </el-form-item>
      <el-form-item label="密码:" prop="pwd">
        <el-input v-model="账号.data.pwd" type="password" autocomplete="off" show-password />
      </el-form-item>
      <!-- <el-form-item label="Age" prop="age">
        <el-input v-model.number="ruleForm.age" />
      </el-form-item> -->
      <el-form-item>
        <el-button type="primary" @click="登录">登录</el-button>
        <!-- <el-button @click="resetForm(ruleFormRef)">Reset</el-button> -->
      </el-form-item>
    </el-form>
  </div>
</template>

<script setup  lang="ts">
/**
 * 登录，输入账号，输入密码
 * 输入root号的话需要邮箱验证码
 * 输入
 * user为直接的账号
 * admin为ca开头的
 * 
 */
import myconfig from "@/config/config.js";
import axios from 'axios';
import { reactive, ref } from 'vue'

const 账号 = reactive({
  data: {
    num: '',
    pwd: ''

  }
})



// const 状态信息 = reactive(
//   {
//     data: {
//       root: {
//         root_num: 0,
//       },
//       admin: {
//         admin_num: 0,
//       },
//       user: {
//         user_num: 0,
//       },
//       pwd: ''
//     }
//   }
// )

const 登录 = () => {
  console.log(账号);
  if (/^ca/.test(账号.data.num)) {
    let params = {
      admin_num: 账号.data.num.slice(2, 账号.data.num.length),
      admin_pwd: 账号.data.pwd
    }
    axios.get(myconfig.SERVER_URL + '/admin/adminLogin?' + myconfig.getParams(params)).then(
      (res) => {
        console.log(res.data);
        if (res.status == 200 && res.data == 'ok') {
          console.log("admin登录成功");
          localStorage.setItem("end_time", Number((Date.now()) + (30 * 24 * 60 * 60 * 1000)).toString());
          // localStorage.setItem("token", res.data.token);
          // localStorage.setItem("user", JSON.stringify(res.data.user));
          // localStorage.setItem("status", res.data.status);
          // localStorage.setItem("role", res.data.role);
          // localStorage.setItem("isLogin", "true");
          // localStorage.setItem("isRoot", "false");
          // localStorage.setItem("isAdmin", "true");
          // localStorage.setItem("isUser", "false");
        }
        else {
          console.log("admin登录失败");
        }
      })
  } else {
    if (/^-?\d{1,16}$/.test(账号.data.num)) {
      
      let params = {
        user_num: 账号.data.num,
        user_pwd: 账号.data.pwd
      }
      console.log(myconfig.SERVER_URL + '/user/userLogin?' + myconfig.getParams(params));
      // axios.get(myconfig.SERVER_URL + '/user/userLogin?' + myconfig.getParams(params)).then()
      axios.get(myconfig.SERVER_URL + '/user/userLogin?' + myconfig.getParams(params)).then(
        (res) => {

          if (res.status == 200 && res.data == 'ok') {
            console.log("user登录成功");
            localStorage.setItem("end_time", Number((Date.now()) + (30 * 24 * 60 * 60 * 1000)).toString());
          }
          else {
            console.log("user登录失败");
          }
        })
    } else {
      console.log("账号格式不对");
    }
  }
}
</script>

<style scoped></style>
