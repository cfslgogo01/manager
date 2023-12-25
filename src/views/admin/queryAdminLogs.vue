<template>
  <div style="padding-bottom: 60px;">

    <!-- <el-button @click="onclick">reset date filter</el-button> -->
    <!-- <el-button @click="clearFilter">reset all filters</el-button> -->
    <el-table ref="tableRef" row-key="date" :data="所有管理员日志.data" style="width: 100%" max-height="600px"
      highlight-current-row="true" show-overflow-tooltip="true" empty-text="空">
      <!-- <el-table-column prop="date" label="日志编号" sortable width="180" /> -->
      <el-table-column prop="adminlog_type" label="操作类型" sortable min-width="180px">
        <template #default="scope">

          <el-tag :type="((scope) => {
            return /生成/.test(scope.row.adminlog_type) ? '' : (/同意/.test(scope.row.adminlog_type) ? 'success' : 'warning')
          })(scope)
            " disable-transitions> {{
    scope.row.adminlog_type }}</el-tag>
        </template>
      </el-table-column>

      <el-table-column prop="admin_num" label="管理员号" sortable min-width="180px" />
      <el-table-column prop="adminlog_result" label="操作结果" min-width="180px">
        <template #default="scope">

          <el-tag
            :type="/成功/.test(scope.row.adminlog_result) || /修改为/.test(scope.row.adminlog_result) ? 'success' : 'info'"
            disable-transitions> {{
              scope.row.adminlog_result }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="adminlog_date" label="日期" sortable min-width="180px" />

      <!-- <el-table-column prop="date" label="Date" sortable width="180" column-key="date" :filters="[
      { text: '2016-05-01', value: '2016-05-01' },
      { text: '2016-05-02', value: '2016-05-02' },
      { text: '2016-05-03', value: '2016-05-03' },
      { text: '2016-05-04', value: '2016-05-04' },
    ]" :filter-method="filterHandler" />
    <el-table-column prop="name" label="Name" width="180" />
    <el-table-column prop="address" label="Address" :formatter="formatter" />

    <el-table-column sortable prop="tag" label="Tag" width="100" :filters="[
      { text: 'Home', value: 'Home' },
      { text: 'Office', value: 'Office' },
    ]" :filter-method="filterTag" filter-placement="bottom-end">
      <template #default="scope">
        <el-tag :type="scope.row.tag === 'Home' ? '' : 'success'" disable-transitions>{{ scope.row.tag }}</el-tag>
      </template>
    </el-table-column> -->
    </el-table>
  </div>
</template>

<script setup lang="ts" >
/**
 * 就是查询所有的
 * 现在咱们不考虑筛选的问题！
 */
import { ref, reactive } from "vue";
import axios from "axios";
import moment from "moment";
import myconfig from '@/config/config.js';
import type { TableColumnCtx, TableInstance } from "element-plus";
import { User } from "@element-plus/icons-vue";
const 所有管理员日志 = reactive(
  {
    data: []
  }
)
axios.get(myconfig.SERVER_URL + "/admin/queryConAdminLogs").then(
  res => {
    // console.log(res.data);
    if (res.status == 200) {
      所有管理员日志.data = res.data
      console.log(所有管理员日志.data);
    }
  }
)
interface User {
  date: string;
  name: string;
  address: string;
  tag: string;
  [key: string]: any; // 添加这一行
}

const tableRef = ref<TableInstance>();

const resetDateFilter = () => {
  tableRef.value!.clearFilter(["date"]);
};
const clearFilter = () => {
  tableRef.value!.clearFilter();
};
const formatter = (row: User, column: TableColumnCtx<User>) => {
  console.log(row);
  console.log("列" + JSON.stringify(column));
  return row.address;
};
const filterTag = (value: string, row: User) => {
  return row.tag === value;
};
const filterHandler = (
  value: string,
  row: User,
  column: TableColumnCtx<User>
) => {
  const property = column["property"];
  return row[property] === value;
};

const tableData: User[] = reactive([
  {
    date: "2016-05-03",
    name: "Tom",
    address: "No. 189, Grove St, Los Angeles",
    tag: "Home",
  },
  {
    date: "2016-05-02",
    name: "Tom",
    address: "No. 189, Grove St, Los Angeles",
    tag: "Office",
  },
  {
    date: "2016-05-04",
    name: "Tom",
    address: "No. 189, Grove St, Los Angeles",
    tag: "Home",
  },
  {
    date: "2016-05-01",
    name: "Tom",
    address: "No. 189, Grove St, Los Angeles",
    tag: "Office",
  },
]);
const onclick = () => {
  tableData.forEach((item) => {
    tableData[0].name = "1";
    console.log(item);
  });
};
</script>



<style scoped></style>