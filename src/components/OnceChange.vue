<template>
    <div>
        <el-drawer v-model="是否显示" :title="title" direction="rtl" :before-close="关闭回调"
            :size="myconfig._userAgent ? '80%' : '30%'">
            <el-form label-width="auto" label-position="top">
                <el-form-item label="Activity name" :prop="修改类型.result" :required="true">
                    <template #label>
                        <el-text type="primary">修改类型</el-text>
                    </template>
                    <div>
                        <el-radio-group v-model="修改类型.result">
                            <el-radio v-for="item in 修改类型.data" :label="item.label" :key="item.label">{{ item.title
                            }}</el-radio>
                        </el-radio-group>
                    </div>
                </el-form-item>
                <el-form-item label="Activity zone" :prop="修改时间.result" v-show="修改类型.result == 1"
                    :required="修改类型.result == 1">
                    <template #label>
                        <el-text type="primary">修改时间</el-text>
                    </template>
                    <div v-show="修改类型.result == 1">


                        <el-radio-group v-model="修改时间.result">
                            <el-radio v-for="item in 修改时间.data" :label="item.label" :key="item.label">{{ item.title
                            }}</el-radio>
                        </el-radio-group>
                    </div>
                </el-form-item>
                <el-form-item label="Activity time" :prop="修改当前是否有效.result" v-show="修改类型.result == 2"
                    :required="修改类型.result == 2">
                    <template #label>
                        <el-text type="primary">修改当前是否有效</el-text>
                    </template>
                    <div v-show="修改类型.result == 2">
                        <el-radio-group v-model="修改当前是否有效.result">
                            <el-radio v-for="item in 修改当前是否有效.data" :label="item.label" :key="item.label">{{ item.title
                            }}</el-radio>
                        </el-radio-group>
                    </div>
                </el-form-item>

                <el-form-item>
                    <el-button type="primary" @click="确定修改"> 确定修改 </el-button>
                    <!-- <el-button type="primary" @click="onSubmit">Create</el-button> -->
                    <el-button @click="是否显示 = false">取消修改</el-button>
                </el-form-item>
            </el-form>
        </el-drawer>










        <!-- background -->


    </div>
</template>
  
  
<script setup >
import { ref, reactive, provide, inject } from "vue";
import { ElMessage } from 'element-plus';
import axios from "axios";
import moment from "moment";
import "@/config/config.js";
import myconfig from '@/config/config';
const 是否显示 = inject('是否显示');
const 需要的信息 = inject('需要的信息');
const props = defineProps({
    // title: '管理员修改',
    title: {
        type: String,
        default: '管理员修改'
    },
    URL: ''
    // default: ''
})
console.log(props)
const 修改类型 = reactive({
    data: [
        {
            label: 1,
            title: "有效时间"
        },
        {
            label: 2,
            title: "当前是否有效"
        },
    ]
    ,
    result: 0
})
const 修改时间 = reactive({
    data: [
        {
            label: 1,
            title: "周卡(7天)",
            value: 7 * 24 * 60 * 60
        },
        {
            label: 2,
            title: "月卡(30天)",
            value: 30 * 24 * 60 * 60
        },
        {
            label: 3,
            title: "季卡(90天)",
            value: 90 * 24 * 60 * 60
        },
        {
            label: 4,
            title: "年卡(365天)",
            value: 365 * 24 * 60 * 60
        },
        {
            label: 5,
            title: "永久卡(9999天)",
            value: 9999 * 24 * 60 * 60
        },
    ]
    ,
    result: 0
})
const 修改当前是否有效 = reactive({
    data: [
        {
            label: 1,
            title: "有效",
            value: "true"
        },
        {
            label: 2,
            title: "无效",
            value: "false"
        },
    ]
    ,
    result: 0
})

const 确定修改 = () => {
    需要的信息.data.isok = 'false'
    try {
        let params = {
            root_num: myconfig.getroot_num(),
            admin_num: myconfig.getadmin_num(),
            c_type_num: 修改类型.result,
            old_value: "",
            new_value: "",
            ainfo_num: 需要的信息.data.ainfo_num
        }
        if (修改类型.result == 1) {
            //有效时间
            params.old_value = String(需要的信息.data.valid_time_num)
            // console.log(String(修改时间.data[修改时间.result - 1].value));
            params.new_value = String(修改时间.data[修改时间.result - 1].value)
        } else if (修改类型.result == 2) {
            //修改当前是否有效
            params.old_value = String(需要的信息.data.is_work)
            params.new_value = String(修改当前是否有效.data[修改当前是否有效.result - 1].value)
        } else {
            ElMessage({
                message: props.title + '失败',
                grouping: true,
                type: 'error',
            })
            return
        }

        axios.get(myconfig.SERVER_URL + props.URL + "?" + myconfig.getParams(params)).then(
            res => {
                console.log(res);
                if (res.status == 200) {
                    ElMessage({
                        message: props.title + '成功',
                        grouping: true,
                        type: 'success',
                    })
                    需要的信息.data.isok = 'true'
                    是否显示.value = false
                    return;
                } else {
                    ElMessage({
                        message: props.title + '失败',
                        grouping: true,
                        type: 'error',
                    })
                }
            }
        )
    } catch (e) {
        ElMessage({
            message: props.title + '失败',
            grouping: true,
            type: 'error',
        })
    }



}
const 关闭回调 = () => {
    是否显示.value = false;
    return true;
}
</script>
  
<style scoped></style>
  