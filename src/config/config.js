// config.js
import { el } from 'element-plus/es/locales.mjs';
import { ref, reactive } from 'vue';
export const SERVER_URL = 'https://127.0.0.1:8088';
export const _userAgent = /Mobile/i.test(navigator.userAgent);
const
    links = reactive({
        rootlinks: [
            {
                label: '生成组',
                links: [
                    { name: '创建管理员', path: '/createAdmin' },
                    { name: '生成激活码', path: '/generateCode' },

                ]
            },
            {
                label: '修改组',
                links: [

                    { name: '为「发起」授权', path: '/agreeInitiation' },
                    // { name: '「决定」修改激活信息', path: '/decideChange' },

                ]
            },
            {
                label: '查询组',
                links: [

                    { name: '查询用户权限', path: '/queryUserActivation' },
                    { name: '查询管理员日志', path: '/queryAdminLogs' },
                    { name: '查询用户日志', path: '/queryUserLogs' },
                    { name: '查询功能列表', path: '/queryFuncStatus' },
                ]
            }

        ],
        adminlinks: [
            {
                label: '生成组',
                links: [
                    { name: '生成激活码', path: '/generateCode' },

                ]
            },
            {
                label: '修改组',
                links: [
                    { name: '为「发起」授权', path: '/agreeInitiation' },
                    // { name: '「发起」修改激活信息', path: '/initiateChange' },

                ]
            },
            {
                label: '查询组',
                links: [

                    { name: '查询用户权限', path: '/queryUserActivation' },
                    { name: '查询管理员日志', path: '/queryAdminLogs' },
                    { name: '查询用户日志', path: '/queryUserLogs' },
                    { name: '查询功能列表', path: '/queryFuncStatus' },
                ]
            }

        ],
        userlinks: [
            {
                label: '激活组',
                links: [
                    { name: '激活功能', path: '/activateFunc' },
                ]
            },
            {
                label: '查询组',
                links: [

                    { name: '查询自身激活情况', path: '/queryMyActivation' },
                    { name: '查询自身日志', path: '/queryMyLogs' },
                ]
            }

        ]
    }
    )

const 状态信息 = reactive(
    {
        data: {
            root: {
                root_num: 0,
            },
            admin: {
                admin_num: 0,
            },
            user: {
                user_num: 0,
            }
        }
    }
)
const 跳转到login = () => {
    window.location.assign("/login");
}
const 检查状态信息 = () => {
    if (localStorage.getItem("end_time") == null) {
        return false;
    } else {
        let end_time = localStorage.getItem("end_time");
        console.log("end_time", end_time, Date.now());
        if (end_time <= Date.now()) {
            return false;
        } else {
            return true;
        }
    }
}
const 更新状态信息 = () => {
    if (localStorage.getItem("end_time") == null) {
        localStorage.setItem("end_time", 0);
        window.location.assign("/login");
    } else {
        let end_time = localStorage.getItem("end_time");
        console.log("end_time", end_time, Date.now());
        if (end_time <= Date.now()) {
            console.log(window.location);
            if (window.location.pathname != "/login") {
                window.location.assign("/login");
            }
        }
        if (localStorage.getItem("root_num") == null) {
            localStorage.setItem("root_num", 0);
        } else {
            状态信息.data.root.root_num = localStorage.getItem("root_num");
        }
        if (localStorage.getItem("admin_num") == null) {
            localStorage.setItem("admin_num", 0);
        } else {
            状态信息.data.admin.admin_num = localStorage.getItem("admin_num");
        }
        if (localStorage.getItem("user_num") == null) {
            localStorage.setItem("user_num", 0);
        } else {
            状态信息.data.user.user_num = localStorage.getItem("user_num");
        }
    }
}
更新状态信息()
// const 设置状态信息 = () => {
//     localStorage.setItem("root_num", 状态信息.data.root.root_num);
//     localStorage.setItem("admin_num", 状态信息.data.admin.admin_num);
//     localStorage.setItem("user_num", 状态信息.data.user.user_num);
// }
const getroot_num = () => {
    return 状态信息.data.root.root_num;
}
const getadmin_num = () => {
    return 状态信息.data.admin.admin_num;
}
const getuser_num = () => {
    return 状态信息.data.user.user_num;
}
const queryString = (myrequest) => {
    return Object.keys(myrequest)
        .map(
            (key) =>
                `${encodeURIComponent(key)}=${encodeURIComponent(myrequest[key])}`
        )
        .join("&");
}
function objectToUrlParams(obj) {
    return Object.entries(obj)
        .map(([key, value]) => `${encodeURIComponent(key)}=${encodeURIComponent(value)}`)
        .join('&');
}
// function getAllEntries(obj) {
//     let result = {};

//     for (let [key, value] of Object.entries(obj)) {
//       if (typeof value === 'object' && value !== null) {
//         // 如果值是对象并且不为null，则递归获取其键值对
//         result[key] = getAllEntries(value);
//       } else {
//         // 否则，直接添加键值对
//         result[key] = value;
//       }
//     }

//     return result;
//   }

function getAllEntries2(obj) {
    let result = "";

    for (let [key, value] of Object.entries(obj)) {
        if (typeof value === 'object' && value !== null) {
            // 如果值是对象并且不为null，则递归获取其键值对
            // result[key] = getAllEntries2(value);
            // console.log('zhongj' + JSON.stringify(value));
            // console.log(encodeURIComponent(key) + "=" + encodeURIComponent(JSON.stringify(value) + "&"));
            result += encodeURIComponent(key) + "=" + encodeURIComponent(JSON.stringify(value)) + "&"
        } else {
            // 否则，直接添加键值对
            // result[key] = value;
            result += encodeURIComponent(key) + "=" + (value) + "&"
        }
    }

    return result;
}
export default {
    getroot_num: getroot_num,
    getadmin_num: getadmin_num,
    getuser_num: getuser_num,
    getParams: getAllEntries2,
    SERVER_URL: SERVER_URL,
    _userAgent: _userAgent,
    links: links,
    更新状态信息: 更新状态信息,
    检查状态信息: 检查状态信息
} 
