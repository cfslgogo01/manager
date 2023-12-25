<template>
  <div style="padding-bottom: 60px;">
    <div style="padding-top: 8px;padding-bottom: 10px;">
      <el-text type="primary">输入激活码：</el-text>
    </div>

    <!-- 如果是空的，那么啥都没有
如果是加载中，那就是加载页面
如果返回正确，那就变成绿色
如果返回错误，那就显示红色！
 -->
    <div style="padding-top: 8px;padding-bottom: 6px;">
      <el-input v-model="用户激活码" key="input_admin_num" id="input_admin_num" placeholder="Please input admin_num"
        @input="检查用户激活码" maxlength="32">
        <template #suffix="">
          <!-- <el-button  link> -->
          <el-text type="warning"> <el-icon v-show="!当前是否为有效激活码 && 用户激活码.length != 0">
              <Loading />
            </el-icon></el-text>
          <el-text type="danger" v-show="当前是否为有效激活码 && 错误的请求">
            <el-icon>
              <CircleClose />
            </el-icon>
          </el-text>
          <el-text type="success" v-show="当前是否为有效激活码 && 正确的请求"> <el-icon>
              <CircleCheck />
            </el-icon></el-text>

          <!-- </el-button> -->

          <el-icon :size="30" :color="color_icon_admin_num" v-show="!true">
            <Warning />
          </el-icon>
        </template>
      </el-input>
    </div>

    <!-- <el-icon :size="30" :color="color_icon_admin_num">
            <CircleCheck v-if="isstandard_input_admin_num" />
            <Warning v-if="!isstandard_input_admin_num" />
        </el-icon> -->

    <br />
    <div v-show="当前是否为有效激活码">
      <div style="padding-bottom: 4px;">
        <el-text type="primary">可激活功能:</el-text>
      </div>
      <div v-show="可以激活的功能们.data.length != 0" style="padding-bottom: 10px;">
        <el-checkbox v-model="是否全选了" :indeterminate="是否半选了" @change="全选半选检测" id="checkbox_selectAll_f"
          key="checkbox_selectAll_f">全选</el-checkbox>
        <el-checkbox-group v-model="当前已选的功能们.data" key="checkbox_group_select_f" @change="当前已选的功能们的修改">
          <!-- 去掉了v-model因为本来也没用！ -->
          <!-- 为什么使用reactive？因为为了后面全选那里传的是对象，为了保证一样，必须设置为同一个对象！ -->
          <el-checkbox v-for="功能 in 可以激活的功能们.data" :id="功能.func_name" :key="功能.func_num" :label="reactive(功能)">{{
            功能.func_name
          }}
          </el-checkbox>
        </el-checkbox-group>
      </div>
      <div v-show="可以激活的功能们.data.length == 0">
        <el-empty description="该激活码已经完全使用过咯~">
          <template #image>
            (oﾟvﾟ)ノ
          </template>
        </el-empty>
      </div>

    </div>
    <el-button type="primary" @click="确认激活" :disabled="!当前是否为有效激活码">确认激活</el-button>



  </div>
</template>


<script setup>
/**
 * 思路：
 * 输入32位字符，
 * 然后查询已有功能
 * 选择，进行激活！
 * 
 */
import moment from 'moment';
import axios from "axios";
import { ref, reactive, computed } from "vue";
import myconfig from '@/config/config';
import { ElLoading } from 'element-plus'
// const 加载框是否显示 = ref(false)
//查看是否为满足长度的！

const 错误的请求 = ref(false)
const 正确的请求 = ref(false)
const 用户激活码 = ref("")
const 当前是否为有效激活码 = computed(() => {
  return /^[a-z0-9]{32}$/.test(用户激活码.value)
})


// console.log(当前是否为有效激活码);
const 可以激活的功能们 = reactive({
  data: []
})
const 检查用户激活码 = (value) => {
  console.log(value);
  if (/^[a-z0-9]{32}$/.test(value)) {
    // let nowtime = moment()
    let lasttime = new Date().getTime();
    console.log(lasttime);
    let loading = ElLoading.service({
      lock: true,
      text: '查询中...',
      background: 'rgba(0, 0, 0, 0.4)',
    })



    let params = {
      user_num: myconfig.getuser_num(),
      activation_code: 用户激活码.value
    }
    console.log(myconfig.getParams(params));
    axios.get(myconfig.SERVER_URL + "/user/queryFunctionCanBeActivated?" + myconfig.getParams(params)).then(
      res => {
        if (res.status == 200) {
          console.log(res.data);
          可以激活的功能们.data = res.data
          正确的请求.value = true
          错误的请求.value = false
          const nowtime = new Date().getTime();
          if (nowtime - lasttime > 1000) {
            loading.close();
          } else {
            setTimeout(() => {
              loading.close()
            }, 500)
          }
        } else {
          正确的请求.value = false
          错误的请求.value = true
          const nowtime = new Date().getTime();
          if (nowtime - lasttime > 1000) {
            loading.close();
          } else {
            setTimeout(() => {
              loading.close()
            }, 500)
          }
        }



      }
    ).catch(e => {
      console.log(e);
      loading.close();
      正确的请求.value = false
      错误的请求.value = true

      const nowtime = new Date().getTime();
      if (nowtime - lasttime > 1000) {
        loading.close();
      } else {
        setTimeout(() => {
          loading.close()
        }, 500)
      }
    })
  }
}
const 是否全选了 = ref(false)
const 是否半选了 = ref(false)
const 全选 = () => {
  当前已选的功能们.data = 可以激活的功能们.data
  查看是什么状态()
  // 是否全选了.value = true
  // 是否半选了.value = false
}
const 全空 = () => {
  当前已选的功能们.data = []
  查看是什么状态()
  // 是否全选了.value = false
  // 是否半选了.value = false
}
const 查看是什么状态 = () => {
  是否半选了.value = 当前已选的功能们.data.length != 0 && 当前已选的功能们.data.length < 可以激活的功能们.data.length
  是否全选了.value = 当前已选的功能们.data.length != 0 && 当前已选的功能们.data.length == 可以激活的功能们.data.length
}
const 当前已选的功能们 = reactive(
  {
    data: []
  }
)
const 全选半选检测 = (value) => {
  if (value) {
    全选()
  } else {
    全空()
  }
}
const 当前已选的功能们的修改 = (value) => {
  查看是什么状态()
}
const 确认激活 = () => {
  //发送请求，然后就行了
  let params = {
    user_num: myconfig.getuser_num(),
    activation_info: {
      data: 当前已选的功能们.data
    }
  }
  console.log(JSON.stringify(params.activation_info));
  console.log(myconfig.getParams(params));
  axios.get(myconfig.SERVER_URL + "/user/activateFuncsByactivation_code?" + myconfig.getParams(params)).then(
    res => {
      if (res.status == 200) {
        console.log(res.data);
        全空()
        检查用户激活码(用户激活码.value)
      }
    }
  )
}
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
const checkoptions = reactive([
  {
    f_number: 1,
    value: false,
    f_name: "功能1",
  },
  {
    f_number: 2,
    value: true,
    f_name: "功能2",
  },
  {
    f_number: 3,
    value: false,
    f_name: "功能3",
  },
  {
    f_number: 4,
    value: false,
    f_name: "功能4",
  },
  {
    f_number: 5,
    value: false,
    f_name: "功能5",
  },
]);
</script>


<style></style>
