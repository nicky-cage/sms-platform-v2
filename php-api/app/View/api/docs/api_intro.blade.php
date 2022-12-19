@extends('api._layouts.list')

@section('content')
@component('api._slots.panel')
<div class="layui-row">
    <div class="layui-col-md3">&nbsp; </div>
    <div class="layui-col-md6">
        <h1>接口概述</h1><br />
        <h2>1. 使用对象</h2><br />
        <p>
            本文档适用于商户自有系统集成和使用。<br />
            适用场景为：商户需要在自有APP或网站系统中接入我方短信相关功能。<br />
        </p><br />

        <h2>2. 使用规范</h2><br />
        <p>本接口及签名、验签规则遵从通用签名规则和框架，并保持一致，开发时可参考此文档及相关测试网站，获取签名方法或基础测试。</p><br />

        <h2>3. 接口访问地址</h2><br />
        <p>账户注册: 请联系商务获取</p><br />

        <h2>4. 生产环境</h2><br />
        <p>生产环境: 环境地址请联系商务获取</p><br />
    </div>
    <div class="layui-col-md3">&nbsp; </div>
</div>
@endcomponent
@endsection