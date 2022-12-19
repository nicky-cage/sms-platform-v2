<div class="layui-side layui-side-menu">
    <div class="layui-side-scroll">
        <div class="layui-logo" lay-href="home/console.html">
            <span>开发文档</span>
        </div>
        <ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu" lay-filter="layadmin-system-side-menu">
            <li data-name=" home  " class="layui-nav-item">
                <a href="javascript:;" lay-tips="文档介绍" lay-direction="2">
                    <i class="layui-icon layui-icon-home"></i>
                    <cite>文档介绍</cite>
                    <span class="layui-nav-more"></span></a>
                <dl class="layui-nav-child">
                    <dd data-name="console" class="">
                        <a lay-href="/docs/intro">文档介绍</a>
                    </dd>
                </dl>
            </li>
            <li data-name="template " class="layui-nav-item">
                <a href="javascript:;" lay-tips="通用规则" lay-direction="2">
                    <i class="layui-icon layui-icon-set"></i>
                    <cite>通用规则</cite>
                    <span class="layui-nav-more"></span></a>
                <dl class="layui-nav-child">
                    <dd class=""><a lay-href="/docs/api_intro">接口概述</a></dd>
                    <dd class=""><a lay-href="/docs/error_codes">错误代码</a></dd>
                </dl>
            </li>
            <li data-name="template " class="layui-nav-item">
                <a href="javascript:;" lay-tips="签名方法" lay-direction="2">
                    <i class="layui-icon layui-icon-rmb"></i>
                    <cite>签名方法</cite>
                    <span class="layui-nav-more"></span></a>
                <dl class="layui-nav-child">
                    <dd class=""><a lay-href="/docs/sign">接口签名</a></dd>
                </dl>
            </li>
            <li data-name="template " class="layui-nav-item">
                <a href="javascript:;" lay-tips="接口列表" lay-direction="2">
                    <i class="layui-icon layui-icon-group"></i>
                    <cite>接口列表</cite>
                    <span class="layui-nav-more"></span></a>
                <dl class="layui-nav-child">
                    <dd class=""><a lay-href="/docs/send_message">发送短信</a></dd>
                    <dd class=""><a lay-href="/docs/send_verify">发验证码</a></dd>
                    <dd class=""><a lay-href="/docs/message_query">短信查询</a></dd>
                    <dd class=""><a lay-href="/docs/info">账户信息</a></dd>
                    <dd class=""><a lay-href="/docs/balance">余额查询</a></dd>
                </dl>
            </li>
            <span class="layui-nav-bar" style="top: 476px; height: 0px; opacity: 0;"></span>
        </ul>
    </div>
</div>
@include('api.docs._menus_js')