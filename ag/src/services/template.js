import {ADD, DEL, DETAILS, EDIT, LIST} from '@/services/api'
import {METHOD, request} from '@/utils/request'

// 查询表格列表
export async function getTableList(params) {
    return request(LIST, METHOD.POST, params)
}

// 新增
export async function addData(params) {
    return request(ADD, METHOD.POST, params)
}

// 修改
export async function editData(params) {
    return request(EDIT, METHOD.POST, params)
}

// 删除
export async function deleteData(params) {
    return request(DEL, METHOD.POST, params)
}

// 查看详情
export async function getDetails(id) {
    return request(DETAILS, METHOD.GET, {params: {id: id}})
}

export default {
    getTableList,
    addData,
    editData,
    deleteData,
    getDetails
}
