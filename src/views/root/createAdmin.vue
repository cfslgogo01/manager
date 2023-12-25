<template>
  <div style="padding-bottom: 60px;">

    <div class="createAdmin">
      <div>
        <el-text type="primary">输入该管理员的账号：</el-text>
      </div>
      <el-row>
        <el-input v-model="input_admin_num" key="input_admin_num" id="input_admin_num"
          placeholder="Please input admin_num" @input="check_input_admin_num" maxlength="12" style="width: 300px" />
        <!-- <el-icon :size="30" :color="color_icon_admin_num">
            <CircleCheck v-if="isstandard_input_admin_num" />
            <Warning v-if="!isstandard_input_admin_num" />
        </el-icon> -->
        <el-icon :size="30" :color="color_icon_admin_num" v-show="isstandard_input_admin_num">
          <CircleCheck />
        </el-icon>
        <el-icon :size="30" :color="color_icon_admin_num" v-show="!isstandard_input_admin_num">
          <Warning />
        </el-icon>
      </el-row>
      <br>
      <div>
        <el-text type="primary">输入该管理员的密码：</el-text>
      </div>
      <el-row>



        <el-input v-model="input_pwd" :type="typt_input_pwd" key="input_pwd " id="input_pwd"
          placeholder="Please input pwd" @input="check_input_pwd" maxlength="12" style=" width: 300px;">
          <template #suffix>
            <div class="flex justify-space-between mb-4 flex-wrap gap-4">
              <el-button text :plain="true" @click="change_view">
                <el-icon v-if="is_view_pwd">
                  <View />
                </el-icon>
                <el-icon v-if="!is_view_pwd">
                  <Hide />
                </el-icon>
              </el-button>
            </div>
          </template>
        </el-input>
        <el-icon :size="30" :color="color_icon_pwd">
          <CircleCheck v-if="isstandard_input_pwd" />
          <Warning v-if="!isstandard_input_pwd" />
        </el-icon>
        <!-- </div> -->
      </el-row>


      <br>

      <el-button type="primary" @click="onclick_button_create">创建</el-button>

      <div v-if="ismessage">
        <el-text>
          <p>创建的用户名： {{ input_admin_num }}</p>
        </el-text>
        <el-text>
          <p>对应的密码： {{ input_pwd }}</p>
        </el-text>
      </div>
    </div>
  </div>
</template>


<script setup>
import axios from "axios";
// import yonghujihuo from "./yonghujihuo.vue";
import { ref, reactive } from "vue";
const input_admin_num = ref("");
const isstandard_input_admin_num = ref(false);
const color_icon_admin_num = ref("white");
const check_input_admin_num = (value) => {
  console.log(value);
  let patten = /^[a-z0-9_-]{6,18}$/;
  if (patten.test(value)) {
    isstandard_input_admin_num.value = true;
    color_icon_admin_num.value = "#95d475";
  } else {
    isstandard_input_admin_num.value = false;
    color_icon_admin_num.value = "#eebe77";
  }
};

const input_pwd = ref("");
const isstandard_input_pwd = ref(false);
const color_icon_pwd = ref("white");
const check_input_pwd = (value) => {
  console.log(value);
  let patten = /^[a-z0-9_-]{6,18}$/;
  if (patten.test(value)) {
    isstandard_input_pwd.value = true;
    color_icon_pwd.value = "#95d475";
  } else {
    isstandard_input_pwd.value = false;
    color_icon_pwd.value = "#eebe77";
  }
};
const typt_input_pwd = ref("password");
//默认为密码状态
const is_view_pwd = ref(true);
const change_view = (value) => {
  console.log(is_view_pwd.value);
  is_view_pwd.value = !is_view_pwd.value;
  if (is_view_pwd.value) {
    typt_input_pwd.value = "password";
  } else {
    typt_input_pwd.value = "text";
  }
};

import { SERVER_URL } from "../../config/config.js";

console.log(JSON.stringify({ data: [45234, 453, 15] }));
const ismessage = ref(false);
const onclick_button_create = () => {
  if (isstandard_input_admin_num.value && isstandard_input_pwd.value) {
    ismessage.value = true;
    let root_nums = { data: [45234, 453, 15] };
    let root_num = 24;
    let admin_num = input_admin_num.value;
    let pwd = input_pwd.value;
    let params = {
      root_num,
      admin_num,
      pwd,
    };
    // console.log(root_nums);
    // root_nums = JSON.stringify(root_nums)
    // console.log(root_nums);
    // params.root_nums = root_nums
    const queryString = Object.keys(params)
      .map(
        (key) => `${encodeURIComponent(key)}=${encodeURIComponent(params[key])}`
      )
      .join("&");
    console.log(queryString);
    axios
      .get(SERVER_URL + "/root/createAdmin?" + queryString)
      .then((response) => {
        console.log(response);
      });
  } else {
    ismessage.value = false;
  }
};
</script>


<style>
/* .zxcv >>> .el-input {
  height: 200px;
} */
/* //背景色设置为透明 */
/* ::v-deep .el-input__wrapper {
} */
/* .el-text.el-text--primary {
  --el-text-color: #696cff !important;
} */
/* .el-text {
  --el-text-color: #696cff;
  color: #696cff;
}
.el-text--primary {
  --el-text-color: #696cff;
  color: #696cff;
} */
/* .el-input__wrapper {
  background-color: pink !important;
  background-color: transparent !important;
  box-shadow: none !important;
  border-style: solid;
  border-width: 0px;
  border-bottom-width: 1px;

  border-color: #49d292;
} */
/* .el-input__wrapper {

} */
/* //提示框的字体颜色 */
/* ::v-deep input::-webkit-input-placeholder {
  color: #fff;
} */
/* .el-input {
  height: 100px;
  box-shadow: none !important;
} */
</style>
