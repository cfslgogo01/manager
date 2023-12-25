<template>
  <div style="padding-bottom: 60px;">
    <!-- background -->
    <!-- <el-pagination layout="prev, pager, next" pager-count="7" :total="500" :default-page-size="20" :page-size="20" /> -->

    <!-- <el-pagination layout="prev, pager, next" :total="tableData.length" /> -->

    <!-- <el-input> </el-input> -->
    <!-- <el-button type="primary">查询</el-button> -->
    <!-- <el-button type="primary"> 修改</el-button> -->
    <!-- <el-button type="primary" @click="() => { }"> 测试</el-button> -->

    <el-table max-height="600px" lazy="true" :data="没有第二同意的列表.data" table-layout="fixed">

      <el-table-column label="序号" width="52px" type="index" />
      <!-- <el-table-column label="激活信息号" prop="ainfo_num" /> -->
      <el-table-column label="申请管理员" width="100px" prop="admin_num_one" />
      <el-table-column label="用户号" prop="ainfo_num" />
      <el-table-column label="功能名" width="100px" prop="func_name" />
      <el-table-column label="旧值" prop="old_value" />
      <el-table-column label="新值" prop="new_value" />
      <el-table-column label="操作">
        <template #default="scope">
          <el-button type="primary" @click="同意一下(scope.row)" link> 同意 </el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>


<script setup >
/**
 * 为 发起 授权，也就是说，
 * 先查询，然后点同意
 * GET /root/queryAllnotFreeFuncs
 * 然后渲染
 * 然后同意
 */
import { ref, reactive } from "vue";
import axios from "axios";
import moment from "moment";
import { ElMessageBox, ElMessage } from 'element-plus';
import "@/config/config.js";
import myconfig from '@/config/config';
const 没有第二同意的列表 = reactive({
  data: []
})
const 更新自己页面的表格 = () => {
  axios.get(myconfig.SERVER_URL + "/root/querySecondAuthorization").then(
    res => {
      if (res.status == 200) {
        没有第二同意的列表.data = res.data
        console.log(没有第二同意的列表.data);
      }
    }
  )
}
更新自己页面的表格()
const 同意一下 = (row) => {
  // console.log(row);
  let params = {
    root_num: myconfig.getroot_num(),
    initiate_num: row.initiate_num,
    c_type_num: row.c_type_num,
    old_value: row.old_value,
    new_value: row.new_value,
    ainfo_num: row.ainfo_num
  }

  ElMessageBox.confirm(
    '你现在正将要同意一条「发起」请问是否继续?',
    '提示：',
    {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning',
    }
  )
    .then(() => {
      axios.get(myconfig.SERVER_URL + "/root/agreeOthersInitiate?" + myconfig.getParams(params)).then(
        res => {
          if (res.status == 200) {
            ElMessage({
              type: 'success',
              message: '操作成功！',
            })

            更新自己页面的表格()
          } else {
            ElMessage({
              type: 'info',
              message: '操作取消！',
            })
          }
        }
      )


    })
    .catch(() => {
      ElMessage({
        type: 'info',
        message: '操作取消！',
      })
    })
}
</script>

<style scoped></style>
