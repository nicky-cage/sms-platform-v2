@extends('api._layouts.list')

@section('content')
@component('api._slots.panel')
<div class="layui-row">
    <div class="layui-col-md3">&nbsp; </div>
    <div class="layui-col-md6">
        <h1>技术对接文档</h1><br />
        <h2>一 对接流程说明</h2><br />
        <ul>
            <li>1. 联系运营人员，接入对接流程</li>
            <li>2. 联系运营人员，提交商户资料，获取商户后台</li>
            <li>3. 技术开发<br />
                <ul style="margin-left: 50px">
                    <li>发送短信</li>
                    <li>发验证码</li>
                    <li>短信查询</li>
                    <li>账户信息</li>
                    <li>余额查询</li>
                </ul>
            </li>
            <li>4. 开发完成后，联系商务正式上线</li>
            <li>5. 对接完成</li>
        </ul>
        <br /><br />
        <h1>二 其他</h1>
        <h2>&nbsp;</h2>
        <ul>
            <li><a lay-href="/docs/sign">2.1 接口签名</a></li>
        </ul>
    </div>
    <div class="layui-col-md3">&nbsp; </div>
</div>
@include('api.docs._menus_js')
@endcomponent
@endsection