<div class="layui-row layui-col-space15">
    <div class="layui-col-md12">
        <div class="layui-card">
            <div class="layui-card-body" style="padding: 20px">
                <h1>在线测试:</h1><br />
                <h2>提交内容:</h2><br />
                <blockquote class="layui-elem-quote">
                    <form class="layui-form form-api" method="post" action="{{$url ?? ''}}">
                        {{$slot}}
                        <div class="layui-row">
                            <div class="layui-col-lg5">&nbsp;</div>
                            <div class="layui-col-lg4">
                                <button type="button" class="layui-btn btn-submit" lay-filter="sp-save">获取结果</button>
                                <button type="button" class="layui-btn layui-btn-danger sp-btn-cancel" lay-filter="cancel">重置表单</button>
                            </div>
                        </div>
                        <div class="layui-col-lg2">&nbsp;</div>
                    </form>
                </blockquote><br />
                <h2>生成结果</h2><br />
                <blockquote class="layui-elem-quote">
                    <pre class="layui-code" id="request_result">
</pre>
                </blockquote>
            </div>
        </div>
    </div>
</div>
<script>
    const get_params = function(data) {
        // let data = this_form.serializeArray();
        let param = {};
        for (let k in data) {
            let item = data[k];
            if (item.name == "app_key" || item.name == "sign" || item.value == "") {
                continue;
            }
            param[item.name] = item.value;
        }
        return param;
    };
    const get_sign = function(data, key) {
        let sign_str = '';
        Object.keys(data).sort().forEach(function(key) {
            if (key != 'app_key' && key != 'sign') {
                sign_str += key + '=' + data[key] + '&';
            }
        });
        sign_str += 'key=' + key;
        //console.log(sign_str);
        return md5(sign_str);
    };
</script>