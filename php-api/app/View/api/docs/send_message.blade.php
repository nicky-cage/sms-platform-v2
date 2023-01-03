@extends('api._layouts.doc')

@section('content')
@component('api._slots.panel')
<h1>发送短信</h1><br />
<h2>一 短信发起</h2><br />
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
                    <td>/v1/send_message</td>
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
                    <td>sender_number</td>
                    <td>string</td>
                    <td style="text-align: left">
                        发送方手机号码, 必填<br />
                        不同渠道有不同要求: <br />
                        中国联通: <br />
                        1. 要求sender id= 79 、 886、 852 必须真实OA, 不可以后缀 <br />
                        2. 目前只支持联通号段 <br />
                        具体请联系客户服务人员获取详情
                    </td>
                </tr>
                <tr>
                    <td>receiver_number</td>
                    <td>string</td>
                    <td style="text-align: left">
                        接收方手机号码, 必填<br />
                        不需要带国家前缀, 系统会自动判断
                    </td>
                </tr>
                <tr>
                    <td>content</td>
                    <td>string</td>
                    <td>短信内容</td>
                </tr>
                <tr>
                    <td>notify_url</td>
                    <td>string</td>
                    <td>异步回调地址</td>
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
    "send_number":"83912399",
    "send_number":"861923123",
    "content":"1.23",
    "notify_url":"1.23",
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
                    <td>int</td>
                    <td>短信订单编号</td>
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
        "order_number":"2022xxxxxxx",
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
    <label class="layui-form-label">接收号码</label>
    <div class="layui-input-inline" style="width: 25%">
        <input name="receiver_number" id="receiver_number" placeholder="请输入接收手机号码" autocomplete="off" class="layui-input" value="{{mt_rand(100, 999)}}" />
    </div>
</div>
<div class="layui-row layui-form-item">
    <label class="layui-form-label">发送号码</label>
    <div class="layui-input-inline" style="width: 25%">
        <input name="sender_number" id="sender_number" placeholder="请输入手机号码" autocomplete="off" class="layui-input" value="{{mt_rand(100, 999)}}" />
    </div>
</div>
<div class="layui-row layui-form-item">
    <label class="layui-form-label">短信内容</label>
    <div class="layui-input-inline" style="width: 75%">
        <input name="content" id="content" placeholder="请输入短信内容" autocomplete="off" class="layui-input" />
    </div>
</div>
<div class="layui-row layui-form-item">
    <label class="layui-form-label">回调地址</label>
    <div class="layui-input-inline" style="width: 75%">
        <input name="notify_url" id="notify_url" placeholder="请输入回调地址" autocomplete="off" class="layui-input" />
    </div>
</div>
<div class="layui-row layui-form-item">
    <label class="layui-form-label">参数签名</label>
    <div class="layui-input-inline" style="width: 75%">
        <input name="sign" id="sign" placeholder="参数签名自动生成" autocomplete="off" class="layui-input" readonly="readonly" />
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