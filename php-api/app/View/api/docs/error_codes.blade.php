@extends('api._layouts.list')

@section('content')
@component('api._slots.panel')
<div class="layui-row">
    <div class="layui-col-md3">&nbsp;</div>
    <div class="layui-col-md6">
        <table class="layui-table">
            <colgroup>
                <col width="25%" />
                <col />
            </colgroup>
            <thead>
                <tr>
                    <th>错误代码</th>
                    <th>错误说明</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>0</td>
                    <td>操作正常返回结果</td>
                </tr>
                <tr>
                    <td>10000 </td>
                    <td>系统异常,请联系管理员</td>
                </tr>
                <tr>
                    <td>10010 </td>
                    <td>参数错误,请检查参数</td>
                </tr>
                <tr>
                    <td>10020 </td>
                    <td>API KEY 无效</td>
                </tr>
                <tr>
                    <td>10030 </td>
                    <td>签名效验失败</td>
                </tr>
                <tr>
                    <td>10300 </td>
                    <td>用户尚未通过商户认证</td>
                </tr>
                <tr>
                    <td>10320 </td>
                    <td>用户账户不存在</td>
                </tr>
                <tr>
                    <td>10340 </td>
                    <td>账户余额不足</td>
                </tr>
                <tr>
                    <td>30010 </td>
                    <td>请联系人工, 等待本司人工处理</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="layui-col-md3">&nbsp;</div>
</div>
@endcomponent
@endsection