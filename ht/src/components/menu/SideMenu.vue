<template>
    <a-layout-sider v-model="collapsed" :class="['side-menu', 'beauty-scroll', isMobile ? null : 'shadow']" :collapsible="collapsible"
                    :theme="sideTheme" :trigger="null" width="256px">
        <div :class="['logo', theme]">
            <router-link to="/dashboard/workplace">
                <img src="@/assets/img/logo.png">
                <h1>{{ systemName }}</h1>
            </router-link>
        </div>
        <i-menu :collapsed="collapsed" :options="menuData1" :theme="theme" class="menu" @select="onSelect"/>
    </a-layout-sider>
</template>

<script>
import IMenu from './menu'
import {mapState} from 'vuex'

export default {
    name: 'SideMenu',
    components: {IMenu},
    props: {
        collapsible: {
            type: Boolean,
            required: false,
            default: false
        },
        collapsed: {
            type: Boolean,
            required: false,
            default: false
        },
        menuData: {
            type: Array,
            required: true
        },
        theme: {
            type: String,
            required: false,
            default: 'dark'
        }
    },
    computed: {
        sideTheme() {
            return this.theme == 'light' ? this.theme : 'dark'
        },
        ...mapState('setting', ['isMobile', 'systemName']),
        menuData1() {
            let arr = []
            this.menuData.forEach(item => {
                let obj = item
                if (item.children) {
                    obj.child = []
                    item.children.forEach(elem => {
                        if (elem.meta.menu !== 'null') {
                            obj.child.push(elem)
                        }
                    })
                    obj.children = obj.child
                }
                arr.push(obj)
            })
            return arr
        }
    },
    created() {
        // console.log(this.menuData)
    },
    methods: {
        onSelect(obj) {
            this.$emit('menuSelect', obj)
        }
    }
}
</script>

<style lang="less" scoped>
@import "index";
</style>
