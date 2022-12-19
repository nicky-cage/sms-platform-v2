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
                            path: "report_merchants",
                            name: "商户报表",
                            component: () =>
                                import("@/pages/report_merchants/index"),
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
