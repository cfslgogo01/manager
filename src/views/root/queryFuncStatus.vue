<template>
    <div style="padding-bottom: 60px;">

        <el-table   :data="所有功能情况.data" style="width: 100%" max-height="600px"
            :highlight-current-row="true" :show-overflow-tooltip="true" empty-text="空">
            <el-table-column prop="func_name" label="功能名" sortable min-width="180px">
                <template #default="scope">
                    <el-tag
                        :type="/true/.test(scope.row.is_free)   ? 'success' : ''"
                        disable-transitions> {{
                        scope.row.func_name }}</el-tag>

                </template>
            </el-table-column>

            <el-table-column prop="func_num" label="功能号" sortable min-width="150px" />
            <el-table-column prop="is_free" label="是否免费" sortable min-width="200px">
                <template #default="scope">

                    <el-tag
                        :type="/true/.test(scope.row.is_free)   ? 'success' : ''"
                        disable-transitions> {{
                            scope.row.is_free }}</el-tag>
                </template>
            </el-table-column>
- 

        </el-table>
    </div>
</template>

<script setup >
import { ref, reactive, inject, provide } from 'vue'
import axios from 'axios'
import moment from 'moment'
import myconfig from '@/config/config.js'
/**
 * 需要查询所有功能的情况
 * 
 */
const 所有功能情况 = reactive({
    data: []
})
axios.get(myconfig.SERVER_URL + '/root/queryFuncStatus').then(
    (res) => {
        console.log(res.data)
        所有功能情况.data = res.data
    }
)
</script>

<style scoped></style>
