import TabsView from "@/layouts/tabs/TabsView";
import BlankView from "@/layouts/BlankView";

// 路由配置
const options = {
    routes: [
        {
            path: "/login",
            name: "登录页面",
            component: () => import("@/pages/login/index"),
        },
        {
            path: "*",
            name: "404",
            component: () => import("@/pages/exception/404"),
        },
        {
            path: "/403",
            name: "403",
            component: () => import("@/pages/exception/403"),
        },
        {
            path: "/",
            name: "首页",
            component: TabsView,
            redirect: "/login",
            children: [
                {
                    path: "main",
                    name: "后台首页",
                    meta: { icon: "fund" },
                    component: () => import("@/pages/main"),
                },
                {
                    path: "site_manage",
                    name: "网站管理",
                    meta: { icon: "windows" },
                    component: BlankView,
                    children: [
                        {
                            path: "parameter_groups",
                            name: "参数分组",
                            component: () =>
                                import("@/pages/parameter_groups/index"),
                        },
                        {
                            path: "parameters",
                            name: "参数设置",
                            component: () => import("@/pages/parameters/index"),
                        },
                    ],
                },
                {
                    path: "content_manage",
                    name: "内容管理",
                    meta: {
                        icon: "book",
                    },
                    component: BlankView,
                    children: [
                        {
                            path: "notices",
                            name: "公告管理",
                            component: () => import("@/pages/notices/index"),
                        },
                    ],
                },
                {
                    path: "merchants_manage",
                    name: "商户管理",
                    meta: { icon: "shop" },
                    component: BlankView,
                    children: [
                        {
                            path: "merchants",
                            name: "商户列表",
                            component: () => import("@/pages/merchants/index"),
                        },
                        {
                            path: "merchant_accounts",
                            name: "商户账户",
                            component: () =>
                                import("@/pages/merchant_accounts/index"),
                        },
                        {
                            path: "merchant_login_logs",
                            name: "登录记录",
                            component: () =>
                                import("@/pages/merchant_login_logs/index"),
                        },
                        {
                            path: "merchant_logs",
                            name: "操作记录",
                            component: () =>
                                import("@/pages/merchant_logs/index"),
                        },
                    ],
                },
                {
                    path: "app_manage",
                    name: "应用管理",
                    meta: { icon: "apple" },
                    component: BlankView,
                    children: [
                        {
                            path: "apps",
                            name: "应用列表",
                            component: () =>
                                import("@/pages/merchant_apps/index"),
                        },
                        {
                            path: "app_logs",
                            name: "调用日志",
                            component: () =>
                                import("@/pages/merchant_app_logs/index"),
                        },
                    ],
                },
                {
                    path: "sms_manage",
                    name: "短信管理",
                    meta: { icon: "message" },
                    component: BlankView,
                    children: [
                        {
                            path: "message_channels",
                            name: "短信渠道",
                            component: () =>
                                import("@/pages/message_channels/index"),
                        },
                        {
                            path: "message_templates",
                            name: "短信模板",
                            component: () =>
                                import("@/pages/message_templates/index"),
                        },
                        {
                            path: "messages",
                            name: "短信列表",
                            component: () => import("@/pages/messages/index"),
                        },
                        {
                            path: "message_batches",
                            name: "批量发送",
                            component: () =>
                                import("@/pages/message_batches/index"),
                        },
                    ],
                },
                {
                    path: "records_manage",
                    name: "历史记录",
                    meta: { icon: "history" },
                    component: BlankView,
                    children: [
                        {
                            path: "record_completes",
                            name: "发送成功",
                            component: () =>
                                import("@/pages/record_completes/index"),
                        },
                        {
                            path: "record_failures",
                            name: "发送失败",
                            component: () =>
                                import("@/pages/record_failures/index"),
                        },
                        {
                            path: "record_receipts",
                            name: "短信回执",
                            component: () =>
                                import("@/pages/record_receipts/index"),
                        },
                    ],
                },
                {
                    path: "report_manage",
                    name: "报表管理",
                    meta: { icon: "table" },
                    component: BlankView,
                    children: [
                        {
                            path: "report_counts",
                            name: "运营统计",
                            component: () =>
                                import("@/pages/report_counts/index"),
                        },
                        {
                            path: "report_merchants",
                            name: "代理统计",
                            component: () =>
                                import("@/pages/report_merchants/index"),
                        },
                    ],
                },
                {
                    path: "admin_manage",
                    name: "后台管理",
                    meta: { icon: "setting" },
                    component: BlankView,
                    children: [
                        {
                            path: "admins",
                            name: "后台用户",
                            component: () => import("@/pages/admins/index"),
                        },
                        {
                            path: "admin_login_logs",
                            name: "登录日志",
                            component: () =>
                                import("@/pages/admin_login_logs/index"),
                        },
                        {
                            path: "admin_logs",
                            name: "操作日志",
                            component: () => import("@/pages/admin_logs/index"),
                        },
                        {
                            path: "permission_ips",
                            name: "授权地址",
                            component: () =>
                                import("@/pages/permission_ips/index"),
                        },
                    ],
                },
                {
                    path: "system_manage",
                    name: "系统设置",
                    meta: { icon: "global" },
                    component: BlankView,
                    children: [
                        {
                            path: "countries",
                            name: "国家列表",
                            component: () => import("@/pages/countries/index"),
                        },

                        {
                            path: "provinces",
                            name: "省份列表",
                            component: () => import("@/pages/provinces/index"),
                        },
                        {
                            path: "cities",
                            name: "城市列表",
                            component: () => import("@/pages/cities/index"),
                        },
                        {
                            path: "districts",
                            name: "县区列表",
                            component: () => import("@/pages/districts/index"),
                        },
                        {
                            path: "banks",
                            name: "银行列表",
                            component: () => import("@/pages/banks/index"),
                        },
                    ],
                },

                {
                    name: "验权页面",
                    path: "auth/demo",
                    meta: {
                        icon: "file-ppt",
                        authority: {
                            permission: "form",
                            role: "manager",
                        },
                        component: () => import("@/pages/main"),
                    },
                },
            ],
        },
    ],
};

export default options;
