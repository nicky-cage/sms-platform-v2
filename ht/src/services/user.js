import { LOGIN, ROUTES, CHECK_IP } from "@/services/api";
import { METHOD, removeAuthorization, request } from "@/utils/request";

/**
 * 得到当前的路由配置
 * @returns
 */
export async function getRoutesConfig() {
    return request(ROUTES, METHOD.GET);
}

/**
 * 检测当前ip是否有权限
 * @returns
 */
export async function checkIP() {
    return request(CHECK_IP, METHOD.GET, {});
}

/**
 * 登录服务
 * @param name 账户名
 * @param password 账户密码
 * @returns {Promise<AxiosResponse<T>>}
 */
export async function login(name, password, loginType) {
    return request(LOGIN, METHOD.POST, {
        username: name,
        password: password,
        login_type: loginType,
        verify_code: "123123",
    });
}

/**
 * 退出登录
 */
export function logout() {
    localStorage.removeItem(process.env.VUE_APP_ROUTES_KEY);
    localStorage.removeItem(process.env.VUE_APP_PERMISSIONS_KEY);
    localStorage.removeItem(process.env.VUE_APP_ROLES_KEY);
    removeAuthorization();
}

export default {
    login,
    logout,
    getRoutesConfig,
    checkIP,
};
