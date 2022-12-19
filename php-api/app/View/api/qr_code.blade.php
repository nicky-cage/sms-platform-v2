@extends('api._layouts.base')

@section('content')
<div class="layui-row">
    <div class="layui-col-md12" style="text-align: center;">
        <img src="{{$code}}" style="margin:auto" />
    </div>
</div>
<div class="layui-row layui-col-space15">
    <div class="layui-col-md12">
        <div class="layui-card">
            <div class="layui-card-body" style="padding: 20pt">
                <blockquote class="layui-elem-quote" style="font-size: 10pt">
                    <strong>钱包类型: <br />{{$coin_type}} </strong><br /><br />
                    <strong>钱包地址: <br />{{$address}} </strong><br /><br />
                    <strong>转账金额: <br /><span style="color: red; font-size: 12pt">{{$amount}}</span> </strong><br /><br />
                    <strong style="color: red">特别警告: <br />请按照以上精确金额转账, 否则无法正常上分</strong><br />
                </blockquote>
            </div>
        </div>
    </div>
</div>
@endsection