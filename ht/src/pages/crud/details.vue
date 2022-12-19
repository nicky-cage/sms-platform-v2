<template>
    <div class="details">显示详情内容</div>
</template>

<script>
import { templateService } from '@/services/index.js'
export default {
    data () {
        return {
            detailsId: ''
        }
    },
    created () {
        this.detailsId = this.$route.query.id
        this.getDetails()
    },
    methods: {
        getDetails () {
            templateService.getDetails(this.detailsId).then(res => {
                "详情";
            })
        }
    }
}
</script>

<style  scoped lang="less">

</style>