<template>
  <div style="padding-bottom: 60px;">

    <OnceChange title="管理员发起修改" URL="/admin/initiateChange"></OnceChange>

    <!-- background -->
    <div style="padding-bottom: 10px;">

      <el-text type="primary"> 用户号</el-text>
      <el-input v-model="用户账号"> </el-input>
    </div>
    <div style="padding-bottom: 10px;">
      <el-button type="primary" @click="查询一下">查询</el-button>
    </div>
    <!-- <el-button type="primary"> 修改</el-button> -->
    <!-- <el-button type="primary" @click="() => { }"> 测试</el-button> -->

    <el-table ref="multipleTableRef" max-height="600px" :data="查询结果.data" style="width: 100%" table-layout="fixed">

      <el-table-column label="序号" type="index" min-width="60px" />

      <el-table-column label="用户id" min-width="100px">
        <template #default>
          <!-- {{ row }} {{ column }}{{ $index }} -->
          {{ 用户账号 }}
        </template>
      </el-table-column>

      <el-table-column label="功能名" prop="func_name" min-width="100px" />

      <el-table-column label="激活时间" prop="start_time" min-width="150px" />
      <el-table-column label="有效时间" prop="valid_time_num" min-width="150px" />
      <el-table-column label="到期时间" prop="expiration_time" min-width="150px" />


      <el-table-column label="当前状态" min-width="100px">
        <template #default="scope">
          <el-tag class="ml-2" :type="scope.row.is_work == 'true' ? 'success' : 'danger'">
            {{ scope.row.is_work == 'true' ? '有效' : '关闭' }}
          </el-tag>
          <!-- <el-switch v-model="scope.row.value2" class="ml-2" style="
              --el-switch-on-color: #13ce66;
              --el-switch-off-color: #ff4949;
            " /> -->
        </template>
      </el-table-column>
      <el-table-column prop="activation_code" label="激活码" min-width="150px">
        <template #default="{ row }">
          <div class="_code">
            <el-input class="custom-input" v-model="row.activation_code" type="password" show-password />
          </div>
        </template>
      </el-table-column>
      <el-table-column label="修改">
        <template #default="scope">
          <el-button type="primary" link @click="进行一次修改(scope.row)"> 修改 </el-button>
        </template>
      </el-table-column>
    </el-table>


  </div>
</template>


<script setup >
/**
 * 查询用户权限
 * 输入一个用户账号，然后进行查询！
 */
import OnceChange from '@/components/OnceChange.vue';
const funcc = (scope) => {
  return scope.row.is_free == 'false' ? 'success' : 'danger';
}
import myconfig from '@/config/config';
import { ref, reactive, provide, inject, watch } from "vue";
import axios from "axios";
import moment from "moment";
import "@/config/config.js";
const 用户账号 = ref()
const 查询结果 = reactive({
  data: []
})
const myrequest = reactive({
  user_num: null, //用户id
});
const 查询一下 = () => {
  myrequest.user_num = 用户账号.value
  axios.get(myconfig.SERVER_URL + "/root/queryUserAcivation?" + myconfig.getParams(myrequest)).then(
    res => {
      console.log(res);
      if (res.status == 200) {
        查询结果.data = res.data
        console.log(查询结果.data);
      }
    }
  )
}
const 表单是否显示 = ref(false)
provide('是否显示', 表单是否显示);
const 一条需要的信息 = reactive({
  data: {}
})
provide('需要的信息', 一条需要的信息);
watch(一条需要的信息, (newValue, oldValue) => {
  if (newValue.data.isok == 'true' && oldValue.data.isok == 'true' && 表单是否显示.value == false) {
    查询一下();
    // console.log('ok');
  }
  // console.log(`Ref changed from ` + JSON.stringify(oldValue) + "to" + JSON.stringify(newValue));
});
const 进行一次修改 = (row) => {
  console.log(row);
  表单是否显示.value = true
  一条需要的信息.data = row
}
</script>

<style >
/* ._code .el-input__wrapper {
  box-shadow: none;
  border: 0px;
  border-bottom-width: 0px
} */
</style>
