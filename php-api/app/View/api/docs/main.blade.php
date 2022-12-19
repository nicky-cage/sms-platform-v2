<!DOCTYPE html>
<html>

<head>
    @include('api._elements.head_api')
    <script>
        /^http(s*):\/\//.test(location.href) || alert('请先部署到 localhost 下再访问');
    </script>
</head>

<body class="layui-layout-body">
    <div id="LAY_app">
        <div class="layui-layout layui-layout-admin">
            <!-- 侧边菜单 -->
            @include('api.docs._menus')
            <!-- 页面标签 -->
            <div class="layadmin-pagetabs" id="LAY_app_tabs" style="top: 0px;">
                <div class="layui-icon layadmin-tabs-control layui-icon-prev" layadmin-event="leftPage"></div>
                <div class="layui-icon layadmin-tabs-control layui-icon-next" layadmin-event="rightPage"></div>
                <div class="layui-icon layadmin-tabs-control layui-icon-down">
                    <ul class="layui-nav layadmin-tabs-select" lay-filter="layadmin-pagetabs-nav">
                        <li class="layui-nav-item" lay-unselect>
                            <a href="javascript:;"></a>
                            <dl class="layui-nav-child layui-anim-fadein">
                                <dd layadmin-event="closeThisTabs"><a href="javascript:;">关闭当前标签页</a></dd>
                                <dd layadmin-event="closeOtherTabs"><a href="javascript:;">关闭其它标签页</a></dd>
                                <dd layadmin-event="closeAllTabs"><a href="javascript:;">关闭全部标签页</a></dd>
                            </dl>
                        </li>
                    </ul>
                </div>
                <div class="layui-tab" lay-unauto lay-allowClose="true" lay-filter="layadmin-layout-tabs">
                    <ul class="layui-tab-title" id="LAY_app_tabsheader">
                        <li lay-id="home/console.html" lay-attr="home/console.html" class="layui-this"><i class="layui-icon layui-icon-home"></i></li>
                    </ul>
                </div>
            </div>

            <!-- 主体内容 -->
            <div class="layui-body" id="LAY_app_body" style="top: 50px;">
                <div class="layadmin-tabsbody-item layui-show">
                    <iframe src="/docs/intro" frameborder="0" class="layadmin-iframe"></iframe>
                </div>
            </div>

            <!-- 辅助元素，一般用于移动设备下遮罩 -->
            <div class="layadmin-body-shade" layadmin-event="shade"></div>
        </div>
    </div>
</body>

</html>