import { METHOD, request } from "@/utils/request";
import { roundToNearestMinutes } from "date-fns";
import { getAuthorization } from "../utils/request.js";
import { MSG_DELETE } from "./api.js";

/**
 * get
 * @param url
 * @param params
 * @returns {Promise<AxiosResponse<T>>}
 */
export async function requestGet(url, params) {
    return request(url, METHOD.GET, params);
}

/**
 * get
 * @param url
 * @param params
 * @returns {Promise<AxiosResponse<T>>}
 */
export async function requestPost(url, params) {
    return request(url, METHOD.POST, params);
}

// 查询表格列表
export async function getRecords(url, params) {
    return request(url, METHOD.GET, params);
}

/**
 * 新增记录
 * @param url
 * @param params
 * @returns {Promise<AxiosResponse<T>>}
 */
export async function createRecord(url, params) {
    return request(url, METHOD.POST, params);
}

/**
 * 修改记录
 * @param url
 * @param params
 * @returns {Promise<AxiosResponse<T>>}
 */
export async function updateRecord(url, params) {
    return request(url, METHOD.POST, params);
}

/**
 *
 * @param url
 * @param params
 * @returns {Promise<AxiosResponse<T>>}
 */
export async function editRecord(url, params) {
    return request(url, METHOD.POST, params);
}

/**
 * 编辑
 * @param {*} sender
 * @param {*} is_creating
 * @param {*} create_url
 * @param {*} update_url
 */
export async function editRow(sender, is_creating, create_url, update_url) {
    sender.$refs.ruleForm.validate((valid) => {
        if (!valid) {
            return false;
        }
        let url = is_creating ? create_url : update_url;
        editRecord(url, sender.form).then((res) => {
            let result = res.data;
            if (result.code > 0) {
                sender.$message.error(result.message);
                if (result.code == 405) {
                    this.$router.push("/");
                }
                return;
            }
            sender.$refs.ruleForm.resetFields();
            sender.$message.success(result.message);
            sender.form.current = 1;
            sender.visible = false;
            sender.getTableData();
        });
    });
}

/**
 * 删除记录
 * @param url
 * @param params
 * @returns {Promise<AxiosResponse<T>>}
 */
export async function deleteRecord(url, params) {
    return request(url, METHOD.GET, params);
}

/**
 *
 * @param {*} sender
 * @param {*} url_delete
 * @param {*} params
 */
export async function deleteRow(sender, url_delete, params) {
    sender.$confirm({
        title: "删除数据",
        content: MSG_DELETE,
        okText: "确认",
        cancelText: "取消",
        onOk() {
            deleteRecord(url_delete, params).then((res) => {
                let result = res.data;
                if (result.code > 0) {
                    sender.$message.success(result.message);
                    if (result.code == 405) {
                        this.$router.push("/");
                    }
                    return;
                }
                if (sender.form) {
                    sender.form.current = 1;
                }
                sender.getTableData();
            });
        },
    });
}

/**
 *
 * @param {*} sender
 * @param {*} url_list
 */
export async function listRows(sender, url_list) {
    sender.search.page = sender.pagination.current;
    getRecords(url_list, sender.search).then((res) => {
        let result = res.data;
        if (result.code === 0) {
            sender.tableList = result.data.records;
            sender.pagination.pageSize = result.data.page_size;
            sender.pagination.current = result.data.page;
            sender.pagination.total = result.data.total;
            return;
        }
        sender.$message.error({ content: result.message });
        if (result.code == 405) {
            this.$router.push("/");
        }
    });
}

/**
 *
 * @param {*} sender
 * @param {*} val
 */
export async function pageChange(sender, val) {
    sender.pagination.current = val.current;
    sender.getTableData();
}

/**
 * 获取详情
 * @param url
 * @param id
 * @returns {Promise<AxiosResponse<T>>}
 */
export async function getDetail(url, id) {
    return request(url, METHOD.GET, { params: { id: id } });
}

/**
 * 获取详情
 * @param url
 * @param id
 * @returns {Promise<AxiosResponse<T>>}
 */
export async function getRecord(url, id) {
    return request(url, METHOD.GET, { id: id });
}

export default {
    getRecords,
    editRecord,
    createRecord,
    updateRecord,
    deleteRecord,
    getDetail,
    editRow,
    deleteRow,
    pageChange,
    listRows,
    requestGet,
    requestPost,
    getRecord,
};
