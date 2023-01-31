// 跨域代理前缀
//const HOST_LOCAL = 'http://127.0.0.1:8090/v1'; // 本地环境
const HOST_LOCAL = "http://api.sms.local/v1"; // 本地环境
const HOST_TEST = "https://api.sms.pelab.link/v1"; // 测试环境
const IS_LOCAL =
    location.host.indexOf("local") > 0 ||
    location.host.indexOf("localhost") >= 0 ||
    location.host.indexOf("127.0.0.1") >= 0;
const API_PROXY_PREFIX = IS_LOCAL ? HOST_LOCAL : HOST_TEST;
const BASE_URL = API_PROXY_PREFIX;

// 默认每页数量
const PAGE_SIZE = 15;

// 默认分页
const PAGINATION = { current: 1, pageSize: PAGE_SIZE, total: 0 };

module.exports = {
    PAGINATION,
    PAGE_SIZE,
    BASE_URL,

    LOGIN: `${BASE_URL}/index/login`, // 登录

    UPLOAD_URL: `${BASE_URL}/index/upload`, // 上传文件路径

    ADMIN_LOGIN_LOGS_LIST: `${BASE_URL}/admin_login_logs`, // 登录日志
    ADMIN_LOGIN_LOGS_DELETE: `${BASE_URL}/admin_login_logs/delete`, // 登录日志 - 删除

    ADMIN_LOGS_LIST: `${BASE_URL}/admin_logs`, // 操作日志
    ADMIN_LOGS_DELETE: `${BASE_URL}/admin_logs/delete`, // 操作日志 - 删除

    OPEN_NUMBERS_LIST: `${BASE_URL}/open_numbers`, // 开奖号码

    MENUS_LIST: `${BASE_URL}/menus`,
    MENUS_CREATE: `${BASE_URL}/menus/create`,
    MENUS_UPDATE: `${BASE_URL}/menus/update`,

    ADMIN_ROLES_LIST: `${BASE_URL}/admin_roles`,
    ADMIN_ROLES_CREATE: `${BASE_URL}/admin_roles/create`,
    ADMIN_ROLES_UPDATE: `${BASE_URL}/admin_roles/update`,

    ADMINS_LIST: `${BASE_URL}/admins`,
    ADMINS_CREATE: `${BASE_URL}/admins/create`,
    ADMINS_UPDATE: `${BASE_URL}/admins/update`,

    MERCHANTS_LIST: `${BASE_URL}/merchants`,
    MERCHANTS_CREATE: `${BASE_URL}/merchants/create`,
    MERCHANTS_UPDATE: `${BASE_URL}/merchants/update`,

    MERCHANT_APPS_LIST: `${BASE_URL}/merchant_apps`,
    MERCHANT_APPS_CREATE: `${BASE_URL}/merchant_apps/create`,
    MERCHANT_APPS_UPDATE: `${BASE_URL}/merchant_apps/update`,

    PERMISSION_IPS_LIST: `${BASE_URL}/permission_ips`,
    PERMISSION_IPS_CREATE: `${BASE_URL}/permission_ips/create`,
    PERMISSION_IPS_DELETE: `${BASE_URL}/permission_ips/delete`,

    PLAYERS_LIST: `${BASE_URL}/players`,
    ORDERS_LIST: `${BASE_URL}/orders`,

    PLAYER_ACCOUNTS_LIST: `${BASE_URL}/player_accounts`,

    PLAYS_LIST: `${BASE_URL}/plays`,
    PLAYS_CREATE: `${BASE_URL}/plays/create`,
    PLAYS_UPDATE: `${BASE_URL}/plays/update`,
    PLAYS_DELETE: `${BASE_URL}/plays/delete`,

    PARAMETERS_LIST: `${BASE_URL}/parameters`,
    PARAMETERS_CREATE: `${BASE_URL}/parameters/create`,
    PARAMETERS_UPDATE: `${BASE_URL}/parameters/update`,
    PARAMETERS_DELETE: `${BASE_URL}/parameters/delete`,

    ACTIVITIES_LIST: `${BASE_URL}/activities`,
    ACTIVITIES_CREATE: `${BASE_URL}/activities/create`,
    ACTIVITIES_UPDATE: `${BASE_URL}/activities/update`,
    ACTIVITIES_DELETE: `${BASE_URL}/activities/delete`,

    MSG_DELETE: "数据删除之后将不可恢复! 确定删除此条数据?",

    BALANCES_LIST: `${BASE_URL}/balances`, // 余额记录

    CHECK_IP: `${BASE_URL}/index/check_ip`,

    ROUTES: `${BASE_URL}/routes`,
    LIST: `${BASE_URL}/getList`,
    ADD: `${BASE_URL}/add`,
    EDIT: `${BASE_URL}/edit`,
    DEL: `${BASE_URL}/del`,
    DETAILS: `${BASE_URL}/details`,
};
