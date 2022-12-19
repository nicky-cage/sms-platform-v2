@extends('api._layouts.doc')

@section('content')
@component('api._slots.panel')
<h1>签名生成方法</h1><br />
<h2>概述：</h2><br />
<p>为了保证接口调用的安全性，调用接口时，接口调用方需要按照约定生成签名，并将签名作为调用参数在接口调用时传入。</p><br />
<h2>签名算法：</h2><br />
<strong>签名采用MD5算法进行加密。</strong><br />
<strong>签名步骤：</strong><br />
<p>
    (1) 假设请求参数为(PHP实现) <br />
<pre class="layui-code">
    $data = [ // 原始数据
        'receiver' => 'xxxx',
        'trade_number' => 'xxxx',
        'time' => 123456,
    ];
</pre>

(2) 使用MD5算法对上步骤拼接成的字符串进行加密，生成签名: <br />
<pre class="layui-code">
    ksort($data); // 按照字典序排序
    $requestStr = ''; // 准备加密字符串
    foreach ($data as $k => $v) { 
        if ($k == 'sign' || $v == '') {
            continue;
        }
        $requestStr .= "${k}={$v}&";
    }
    $requestStr .= "key=${APP_KEY}""; // 生成最终准备要加密的字符串
    $sign = md5($requestStr); // 将字符串进行MD5加密
    // 比如最终生成: 036f79245152fbf873731f493446a222
</pre>

(3) 将请求参数中附加sign; <br />
<pre class="layui-code">
    $data['sign'] = $sign;
</pre>

(4) 最终实际请求参数为; <br />
<pre class="layui-code">
    $data = [ // 原始数据
        'receiver' => 'xxxx',
        'trade_number' => 'xxxx',
        'time' => 123456,
        'sign' => '036f79245152fbf873731f493446a222',
    ];
</pre>

(5) 向API服务器地址发送请求; <br />
<pre class="layui-code">
    // 引入三方外部库 Hyperf, 实际依赖 GuzzleHttp, 具体使用方法请自行查阅
    // use GuzzleHttp\Client;
    // use GuzzleHttp\Client;
    // use GuzzleHttp\Exception\GuzzleException;
    // use Hyperf\Guzzle\ClientFactory;
    // use Hyperf\Utils\ApplicationContext;

    $url = 'https://xxxx/v1/send_url'; // 请求地址
    $container = ApplicationContext::getContainer(); 
    $httpClient = $container->get(ClientFactory::class); // 生成请求对象

    $data['sign'] = self::getSign($data);
    $client = HttpClient::getClient(); // 使用 GuzzleHttp\Client;
    $content = $client->post($url, $data); // 发送请求
    $result = json_decode($content); // 获取结果
</pre>
</p>
@endcomponent
@endsection

@section('test')
@component('api._slots.form')
<div class="layui-row layui-form-item">
    <label class="layui-form-label">APP KEY</label>
    <div class="layui-input-inline" style="width: 75%">
        <input name="app_key" placeholder="请输入APP KEY" autocomplete="off" class="layui-input" />
    </div>
</div>
<div class="layui-row layui-form-item">
    <div class="layui-col-lg6">
        <label class="layui-form-label">参数名一</label>
        <div class="layui-input-inline">
            <input name="key_1" lay-verify="required" placeholder="请输入参数名称" autocomplete="off" class="layui-input" />
        </div>
    </div>
    <div class="layui-col-lg6">
        <label class="layui-form-label">参数值一</label>
        <div class="layui-input-inline">
            <input name="value_1" lay-verify="required" placeholder="请输入参数内容" autocomplete="off" class="layui-input" />
        </div>
    </div>
</div>
<div class="layui-row layui-form-item">
    <div class="layui-col-lg6">
        <label class="layui-form-label">参数名二</label>
        <div class="layui-input-inline">
            <input name="key_2" lay-verify="required" placeholder="请输入参数名称" autocomplete="off" class="layui-input" />
        </div>
    </div>
    <div class="layui-col-lg6">
        <label class="layui-form-label">参数值二</label>
        <div class="layui-input-inline">
            <input name="value_2" lay-verify="required" placeholder="请输入参数内容" autocomplete="off" class="layui-input" />
        </div>
    </div>
</div>
<div class="layui-row layui-form-item">
    <div class="layui-col-lg6">
        <label class="layui-form-label">参数名三</label>
        <div class="layui-input-inline">
            <input name="key_3" lay-verify="required" placeholder="请输入参数名称" autocomplete="off" class="layui-input" />
        </div>
    </div>
    <div class="layui-col-lg6">
        <label class="layui-form-label">参数值三</label>
        <div class="layui-input-inline">
            <input name="value_3" lay-verify="required" placeholder="请输入参数内容" autocomplete="off" class="layui-input" />
        </div>
    </div>
</div>
@endcomponent
@endsection