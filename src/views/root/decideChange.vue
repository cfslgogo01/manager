<template>
  <div>

    <OnceChange ainfo_num="1"></OnceChange>




    <!-- background -->


  </div>
</template>


<script setup >
import { ref, reactive } from "vue";
import axios from "axios";
import moment from "moment";
import "@/config/config.js";
import OnceChange from '@/components/OnceChange.vue';
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
      title: "周卡(7天)"
    },
    {
      label: 2,
      title: "月卡(30天)"
    },
    {
      label: 3,
      title: "季卡(90天)"
    },
    {
      label: 4,
      title: "年卡(365天)"
    },
    {
      label: 5,
      title: "永久卡(9999天)"
    },
  ]
  ,
  result: 0
})
const 修改当前是否有效 = reactive({
  data: [
    {
      label: 1,
      title: "有效"
    },
    {
      label: 2,
      title: "无效"
    },
  ]
  ,
  result: 0
})

const radio = ref(3);
</script>

<style scoped></style>
