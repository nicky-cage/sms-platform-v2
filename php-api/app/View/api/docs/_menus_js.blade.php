<script>
    let MAX_TAB_NUM = 8; //最大允许的tab数量
    layui.config({
            base: '/static/layuiadmin/'
        })
        .extend({
            index: 'lib/index'
        })
        .use(['index', 'element', 'jquery'], function() {
            let element = layui.element,
                $ = layui.jquery;
            let tabs_container = "layadmin-layout-tabs"; //顶级tabs容器
            element.on("nav", function(data) {
                let tabs = $("div[lay-filter=" + tabs_container + "] li");
                let over_count = tabs.length - MAX_TAB_NUM; //超出的tab的数量
                if (over_count >= 0) {
                    for (let i = 0; i < over_count; i++) {
                        let tab = tabs.eq(i + 1);
                        let id = tab.attr("lay-id");
                        if (id) {
                            element.tabDelete(tabs_container, id);
                        }
                    }
                }
            });
        });
</script>