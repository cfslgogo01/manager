<template>
   <div style="padding-bottom: 60px;">



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
        </template>
      </el-table-column>
      <el-table-column prop="activation_code" label="激活码" min-width="150px">
        <template #default="{ row }">
          <div class="_code">
            <el-input class="custom-input" v-model="row.activation_code" type="password" show-password />
          </div>
        </template>
      </el-table-column>
      <!-- <el-table-column label="修改">
        <template #default="scope">
          <el-button type="primary" link @click="进行一次修改(scope.row)"> 修改 </el-button>
        </template>
      </el-table-column> -->
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
const 用户账号 = myconfig.getuser_num()
const 查询结果 = reactive({
  data: []
})
const myrequest = reactive({
  user_num: null, //用户id
});
const 查询一下 = () => {
  myrequest.user_num = 用户账号
  axios.get(myconfig.SERVER_URL + "/user/queryUserAcivation?" + myconfig.getParams(myrequest)).then(
    res => {
      console.log(res);
      if (res.status == 200) {
        查询结果.data = res.data
        console.log(查询结果.data);
      }
    }
  )
}

查询一下()
</script>

<style ></style>

