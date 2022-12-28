@extends('api._layouts.doc')

@section('content')
@component('api._slots.panel')
<h1>短信查询</h1><br />
<h2>一 短信查询</h2><br />
<h3>1.1 请求说明：</h3><br />
<div class="layui-row">
    <div class="layui-col-md12">
        <table class="layui-table">
            <colgroup>
                <col width="25%" />
                <col />
            </colgroup>
            <tbody>
                <tr>
                    <td class="layui-bg-gray"><strong>请求方法</strong></td>
                    <td>POST</td>
                </tr>
                <tr>
                    <td class="layui-bg-gray"><strong>调用路径</strong></td>
                    <td>/v1/message_query</td>
                </tr>
                <tr>
                    <td class="layui-bg-gray"><strong>返回类型</strong></td>
                    <td>application/json</td>
                </tr>
            </tbody>
        </table>
    </div>
</div><br />
<h3>1.2 请求参数：</h3><br />
<div class="layui-row">
    <div class="layui-col-md12">
        <table class="layui-table">
            <colgroup>
                <col width="30%" />
                <col width="20%" />
                <col />
            </colgroup>
            <thead>
                <th>参数名称</th>
                <th>参数类型</th>
                <th>说明</th>
            </thead>
            <tbody>
                <tr>
                    <td>app_id</td>
                    <td>string</td>
                    <td>应用编号, 必填</td>
                </tr>
                <tr>
                    <td>order_number</td>
                    <td>int</td>
                    <td>订单编号, 必填</td>
                </tr>
                <tr>
                    <td>sign</td>
                    <td>string</td>
                    <td>请求签名, 必填</td>
                </tr>
            </tbody>
        </table>
    </div>
</div><br />

<h3>1.3 请求示例：</h3><br />
<pre class="layui-code">
{
    "app_id": 168000,
    "order_number": 11,
    "sign":"0e63c8fa39f5c983010035a7d1d30e52",
}
</pre><br />

<h2>二 调用返回</h2><br />
<h3>2.1 返回说明：</h3><br />
<div class="layui-row">
    <div class="layui-col-md12">
        <table class="layui-table">
            <colgroup>
                <col width="25%" />
                <col />
            </colgroup>
            <tbody>
                <tr>
                    <td class="layui-bg-gray"><strong>返回类型</strong></td>
                    <td>json</td>
                </tr>
            </tbody>
        </table>
    </div>
</div><br />

<h3>2.2 返回参数：</h3><br />
<div class="layui-row">
    <div class="layui-col-md12">
        <table class="layui-table">
            <colgroup>
                <col width="30%" />
                <col width="20%" />
                <col />
            </colgroup>
            <thead>
                <th>参数名称</th>
                <th>参数类型</th>
                <th>说明</th>
            </thead>
            <tbody>
                <tr>
                    <td>code</td>
                    <td>int</td>
                    <td>错误代码</td>
                </tr>
                <tr>
                    <td>message</td>
                    <td>string</td>
                    <td>错误信息</td>
                </tr>
                <tr>
                    <td>data</td>
                    <td>[]</td>
                    <td>操作结果</td>
                </tr>
                <tr>
                    <td>data.order_number</td>
                    <td>string</td>
                    <td>订单编号</td>
                </tr>
                <tr>
                    <td>data.template_id</td>
                    <td>string</td>
                    <td>模板编号</td>
                </tr>
                <tr>
                    <td>data.message_id</td>
                    <td>string</td>
                    <td>订单编号 - 渠道</td>
                </tr>
                <tr>
                    <td>data.status</td>
                    <td>int</td>
                    <td>状态 0:待发送 1:成功 2:失败</td>
                </tr>
                <tr>
                    <td>data.send_time</td>
                    <td>int</td>
                    <td>发送时间</td>
                </tr>
                <tr>
                    <td>data.sent_time</td>
                    <td>int</td>
                    <td>完成发送时间</td>
                </tr>
                <tr>
                    <td>data.phone</td>
                    <td>string</td>
                    <td>电话号码</td>
                </tr>
                <tr>
                    <td>data.phone_prefix</td>
                    <td>string</td>
                    <td>电话区号</td>
                </tr>
                <tr>
                    <td>data.phone_full</td>
                    <td>string</td>
                    <td>完整电话号码</td>
                </tr>
                <tr>
                    <td>data.merchant_id</td>
                    <td>string</td>
                    <td>商户编号</td>
                </tr>
                <tr>
                    <td>data.merchant_name</td>
                    <td>string</td>
                    <td>商户名称</td>
                </tr>
                <tr>
                    <td>data.sign</td>
                    <td>string</td>
                    <td>签名</td>
                </tr>
            </tbody>
        </table>
    </div>
</div><br />


<h3>2.3 返回示例：</h3><br />
<pre class="layui-code">
{
    "code": 0,
    "message": "",
    "data": {
        "order_number": "xxx",
        "message_id": "xxx",
        "template_id": "xxx",
        "status": "1",
        "created": "",
        "send_time": "",
        "sent_time": "",
        "merchant_id": "",
        "merchant_name": "",
        "sign":"0e63c8fa39f5c983010035a7d1d30e52",
    }
}
@endcomponent
@endsection

@section('test')
@component('api._slots.form', ['url' => $url])
<div class="layui-row layui-form-item">
    <label class="layui-form-label">APP KEY</label>
    <div class="layui-input-inline" style="width: 75%">
        <input name="app_key" id="app_key" placeholder="请输入APP KEY" autocomplete="off" class="layui-input" value="{{$app_key}}" />
    </div>
</div>
<div class="layui-row layui-form-item">
    <div class="layui-col-lg6">
        <label class="layui-form-label">应用编号</label>
        <div class="layui-input-inline">
            <input name="app_id" id="app_id" lay-verify="required" placeholder="请输入应用编号" autocomplete="off" class="layui-input" value="{{$app_id}}" />
        </div>
    </div>
    <div class="layui-col-lg6"> &nbsp; </div>
</div>
<div class="layui-row layui-form-item">
    <label class="layui-form-label">订单编号</label>
    <div class="layui-input-inline" style="width: 25%">
        <input name="order_number" id="order_number" placeholder="请输入订单编号" autocomplete="off" class="layui-input" value="" />
    </div>
</div>
<div class="layui-row layui-form-item">
    <label class="layui-form-label">参数签名</label>
    <div class="layui-input-inline" style="width: 75%">
        <input name="sign" id="sign" placeholder="请输入参数签名" autocomplete="off" class="layui-input" />
    </div>
</div>
@endcomponent
<script src="/static/js/md5.min.js"></script>
<script>
    layui.use(['jquery', 'layer'], function() {
        let $ = layui.jquery,
            this_form = $(".form-api:first"),
            this_url = this_form.attr("action");

        // 提交结果
        $(document).on("click", ".btn-submit", function() {
            let param = get_params(this_form.serializeArray());
            param['sign'] = get_sign(param, $("#app_key").val());
            sp.post(this_url, param, function(result) {
                $("#request_result").html(JSON.stringify(result));
            });
        });
    });
</script>
@endsection