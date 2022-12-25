<template>
    <common-layout>
        <div class="top">
            <div class="header">
                <img alt="logo" class="logo" src="@/assets/img/logo.png"/>
                <span class="title">{{ systemName }}</span>
            </div>
            <div class="desc">商户后台管理系统 | Merchant Backend Management System</div>
        </div>
        <div class="login">
            <a-form :form="form" @submit="onSubmit">
                <a-alert v-if="error" :closable="true" :message="error" showIcon style="margin-bottom: 24px;" type="error" @close='onClose'/>
                <a-form-item>
                    <a-input
                        v-decorator="['name', {rules: [{ required: true, message: '必须输入后台用户名称', whitespace: true}]}]"
                        autocomplete="autocomplete" placeholder="请输入后台用户名称" size="large">
                        <a-icon slot="prefix" type="user" />
                    </a-input>
                </a-form-item>
                <a-form-item>
                    <a-input
                        v-decorator="['password', {rules: [{ required: true, message: '必须输入后台用户密码', whitespace: true}]}]"
                        autocomplete="autocomplete" placeholder="请输入后台用户密码" size="large" type="password">
                        <a-icon slot="prefix" type="lock"/>
                    </a-input>
                </a-form-item>
                <div>
                    <a-checkbox :checked="true">自动登录</a-checkbox>
                </div>
                <a-form-item>
                    <a-button :loading="logging" htmlType="submit" size="large" style="width: 100%;margin-top: 24px" type="primary">登入系统
                    </a-button>
                </a-form-item>
            </a-form>
        </div>
    </common-layout>
</template>

<script>
import CommonLayout from '@/layouts/CommonLayout'
import {login, checkIP} from '@/services/user'
import {mapMutations} from 'vuex'
import { setAuthorization } from "@/utils/request";

export default {
    name: 'Login',
    components: {CommonLayout},
    data() {
        return {
            logging: false,
            error: '',
            username: 'admin',
            password: 'qwe123',
            form: this.$form.createForm(this)
        }
    },
    mounted: function() {
        checkIP().then((result) => {
            if (!result.data || result.data.code != 0) { 
                this.$router.push({path: '/exception/403', query: {}});
                return;
            }
        });
    },
    computed: {
        systemName() {
            return this.$store.state.setting.systemName
        }
    },
    methods: {
        ...mapMutations('account', ['setUser', 'setPermissions', 'setRoles', 'setAuthorization']),
        onSubmit(e) {
            e.preventDefault()
            this.form.validateFields((err) => {
                if (!err) {
                    this.logging = true
                    const name = this.form.getFieldValue('name')
                    const password = this.form.getFieldValue('password')
                    login(name, password, "admin").then(this.afterLogin)
                    // setTimeout(() => {
                    //     this.logging = false
                    //     this.$router.push('/demo')
                    //     this.$message.success('登录成功', 3)
                    // }, 2000)
                }
            })
        },
        afterLogin(res) {
            this.logging = false
            const result = res.data
            if (result.code > 0) {
                this.error = result.message
                return
            }
            let data = result.data;
            // const {user, permissions, roles} = loginRes.data
            this.setUser(data);
            // this.setPermissions(permissions)
            // this.setRoles(roles)
            let expire_time = (data.last_login_at + 86400) * 1000;
            setAuthorization({token: data.token, expireAt: new Date(expire_time)});
            let that = this;
            this.$message.success("登录成功", 2, function () {
                that.$router.push('/main')
            });
            // 获取路由配置
            // getRoutesConfig().then(result => {
            //     const routesConfig = result.data.data
            //     loadRoutes(routesConfig)
            //     this.$router.push('/demo')
            //     this.$message.success(loginRes.message, 3)
            // })
        },
        onClose() {
            this.error = false
        }
    }
}
</script>

<style lang="less" scoped> @import "login.less"; </style>
