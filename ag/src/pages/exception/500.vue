<template>
    <exception-page :style="`min-height: ${minHeight}`" home-route="/" type="500"/>
</template>

<script>
import ExceptionPage from '@/components/exception/ExceptionPage'
import {mapState} from 'vuex'

export default {
    name: 'Exp500',
    components: {ExceptionPage},
    computed: {
        ...mapState('setting', ['pageMinHeight']),
        minHeight() {
            return this.pageMinHeight ? this.pageMinHeight + 'px' : '100vh'
        }
    }
}
</script>

<style lang="less" scoped></style>
