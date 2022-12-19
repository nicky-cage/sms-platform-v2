<template>
    <div :style="`min-height: ${pageMinHeight}px`" class="new-page">
        <a-row>
            <a-col :span="16" :column="16">
                <a-descriptions title="登录信息" bordered layout="vertical" size="small" :column="16">
                    <a-descriptions-item label="用户名称">{{admin.name}}</a-descriptions-item>
                    <a-descriptions-item label="登录时间">{{datetime(admin.last_login_at)}}</a-descriptions-item>
                    <a-descriptions-item label="上次登录地址">{{admin.last_login_ip}}</a-descriptions-item>
                    <a-descriptions-item label="当前登录地址">{{admin.current_ip}}</a-descriptions-item>
                </a-descriptions>
            </a-col>
        </a-row>
        <!--<h1>{{ $t('content') }}</h1>-->
    </div>
</template>

<script>
import { mapState } from 'vuex';
import { datetime } from '@/utils/datetime.js';

export default {
    name: 'Main',
    i18n: require('./i18n'),
    data() {
        return {}
    },
    computed: {
        admin() { 
            return JSON.parse(localStorage.getItem("admin.user"));
        },
        ...mapState('setting', ['pageMinHeight']),
        desc() {
            return this.$t('description')
        }
    },
    methods: {
        datetime
    }
}
</script>

<style lang="less" scoped>
 @import "index";
</style>