<template>
    <v-chart :data="data" :forceFit="true" :padding="[20, 20, 95, 20]" :scale="scale" height="400">
        <v-tooltip/>
        <v-axis :dataKey="axis1Opts.dataKey" :grid="axis1Opts.grid" :line="axis1Opts.line"
                :tickLine="axis1Opts.tickLine"/>
        <v-axis :dataKey="axis2Opts.dataKey" :grid="axis2Opts.grid" :line="axis2Opts.line"
                :tickLine="axis2Opts.tickLine"/>
        <v-legend :offset="30" dataKey="user" marker="circle"/>
        <v-coord radius="0.8" type="polar"/>
        <v-line :size="2" color="user" position="item*score"/>
        <v-point :size="4" color="user" position="item*score" shape="circle"/>
    </v-chart>
</template>

<script>
const DataSet = require('@antv/data-set')

const sourceData = [
    {item: '引用', a: 70, b: 30, c: 40},
    {item: '口碑', a: 60, b: 70, c: 40},
    {item: '产量', a: 50, b: 60, c: 40},
    {item: '贡献', a: 40, b: 50, c: 40},
    {item: '热度', a: 60, b: 70, c: 40},
    {item: '引用', a: 70, b: 50, c: 40}
]

const dv = new DataSet.View().source(sourceData)
dv.transform({
    type: 'fold',
    fields: ['a', 'b', 'c'],
    key: 'user',
    value: 'score'
})

const scale = [{
    dataKey: 'score',
    min: 0,
    max: 80
}]

const data = dv.rows

const axis1Opts = {
    dataKey: 'item',
    line: null,
    tickLine: null,
    grid: {
        lineStyle: {
            lineDash: null
        },
        hideFirstLine: false
    }
}
const axis2Opts = {
    dataKey: 'score',
    line: null,
    tickLine: null,
    grid: {
        type: 'polygon',
        lineStyle: {
            lineDash: null
        }
    }
}

export default {
    name: 'Radar',
    data() {
        return {
            sourceData,
            data,
            axis1Opts,
            axis2Opts,
            scale
        }
    }
}
</script>

<style scoped>

</style>
