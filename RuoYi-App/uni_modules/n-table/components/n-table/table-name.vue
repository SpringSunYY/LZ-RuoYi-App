<template>
	<view class="table-name" :class="[opt.align]" :style="{ backgroundColor:opt.bg, color: opt.color }">
		<view class="name-tx" :class="{'fwb': opt.bold}" :style="{fontSize: opt.fontSize + 'px'}"> {{opt.title}} </view>
		<view
			class="name-opt iconfont icon-filter"
			v-if="opt.needMenu"
			@click="$emit('menuClick')"
			:style="{ color: opt.color, fontSize: opt.fontSize }"></view>
	</view>
</template>

<script>
	import { defaultNameOpt } from "./config.js"
	export default {
		name: 'tableName',
		props: {
			opt: {
				type: Object,
				default: () => {}
			}
		},
	}
</script>

<style lang="scss" scoped>
	@import "./iconfont.scss";

	.fwb {
		font-weight: bold;
	}

	.left {
		justify-content: flex-start;
	}

	.right {
		justify-content: flex-end;
	}

	.center {
		justify-content: center;
	}

	.table-name {
		display: flex;
		align-items: center;
		width: 100%;
		height: 32px;
		padding: 0 10px;
		box-sizing: border-box;
		position: relative;
	}

	.name-tx {
		// font-size: 26rpx;
		max-width: 100%;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
		// padding-right: 40rpx;
	}

	.name-opt {
		position: absolute;
		right: 10px;
		top: 50%;
		transform: translateY(-50%);
		padding-left: 10px;
	}
</style>
