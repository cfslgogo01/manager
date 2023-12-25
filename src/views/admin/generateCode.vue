<template>
  <div style="padding-bottom: 60px;">
    <el-text type="primary">用户账号：</el-text>
    <div style="padding-top: 8px;padding-bottom: 20px;">
      <el-input v-model="用户账号" placeholder="用户账号" maxlength="10" />
    </div>

    <div style="padding-top: 0%;padding-bottom: 12px;">
      <el-checkbox-group v-model="选择的功能们.data">
        <el-checkbox v-for="(item, index) in 可以激活的功能.data" v-model="item.value" :key="index" :label="item.func_num"
          size="large">{{ item.func_name }}</el-checkbox>
      </el-checkbox-group>
    </div>
    <el-text type="primary">激活时间选择：</el-text>

    <div>
      <div style="padding-bottom: 8px;padding-top: 8px;">
        <el-select v-model="选择的时间" class="m-2" placeholder="Select" size="large">
          <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.time">
            {{ item.label }}</el-option>
        </el-select>
      </div>
    </div>

    <!-- <el-button @click="change" type="primary">生成</el-button> -->

    <!-- <el-text type="primary">激活码：</el-text> -->
    <div style="padding-bottom: 8px; ">
      <el-button @click="发送获得激活码的请求" type="primary">生成激活码</el-button>
      <br />
    </div>
    <el-input v-model="得到的激活码" :disabled="是否能够显示激活码" placeholder="暂无" />
  </div>
</template>


<script setup>
/**
 * 理一下思路，首先是 得到能够激活的功能信息，渲染出来
 * 然后是输入用户号
 * 然后点击生成激活码
 * 然后请求，将激活码显示出来，即可！
 */
const 是否能够显示激活码 = ref(true)
const 可以激活的功能 = reactive({
  data: [],
});
const 用户账号 = ref("");
import axios from "axios";
import moment from "moment";
import myconfig from "@/config/config.js";
import { onMounted, ref, reactive } from "vue";

axios
  .get(myconfig.SERVER_URL + "/admin/queryAllnotFreeFuncs")
  .then((response) => {
    可以激活的功能.data = response.data;
  });
const options = reactive([
  {
    value: "Option0",
    label: "试用(24小时)",
    time: 24 * 60 * 60,
  },
  {
    value: "Option1",
    label: "周卡(7天)",
    time: 7 * 24 * 60 * 60,
  },
  {
    value: "Option2",
    label: "月卡(30天)",
    time: 30 * 24 * 60 * 60,
  },
  {
    value: "Option3",
    label: "季卡(90天)",
    time: 90 * 24 * 60 * 60,
  },
  {
    value: "Option4",
    label: "年卡(365天)",
    time: 365 * 24 * 60 * 60,
  },
]);

const 选择的功能们 = reactive({
  data: [],
});
const 选择的时间 = ref("");

const myrequest = reactive({
  user_num: null, //用户id
  func_nums: "", //开始时间
  vaild_time_num: 0, //有效时间
  admin_num: 123,
});
const 发送获得激活码的请求 = () => {
  myrequest.user_num = parseInt(用户账号.value);
  myrequest.func_nums = JSON.stringify(选择的功能们);
  console.log('选择的时间', 选择的时间.value);
  myrequest.vaild_time_num = parseInt(选择的时间.value);
  myrequest.admin_num = myconfig.getadmin_num();

  console.log(myrequest);
  let queryString = Object.keys(myrequest)
    .map(
      (key) =>
        `${encodeURIComponent(key)}=${encodeURIComponent(myrequest[key])}`
    )
    .join("&");
  console.log(queryString);
  axios
    .get(
      myconfig.SERVER_URL + "/admin/generateActivationcodeToFuncs?" + queryString
    )
    .then((res) => {
      console.log(res);
      if (res.status == 200) {
        得到的激活码.value = res.data
        是否能够显示激活码.value = false
      }
    });
};
const 得到的激活码 = ref("");
</script>