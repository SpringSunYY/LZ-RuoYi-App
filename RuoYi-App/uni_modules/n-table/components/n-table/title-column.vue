<template>
	<view
		class="title-column-item" :class="{'n-border border-right': border}" :style="{width:itemStyle.width,color:borderColor,} ">
		<!-- n-border border-bottom border-right -->
		<view
			class="n-table-title-item"
			@click.stop="handleSort(item)"
			:class="{ 'n-border border-bottom': item.children && item.children.length }"
			:style="{
				height:itemStyle.height,
				lineHeight:itemStyle.lineHeight,
				fontSize: itemStyle.fontSize,
				
				}">
			<view
				:class="['n-table-col-text', 
				{'text-left': titleTextAlign === 'left', 
				'text-center': titleTextAlign === 'center', 
				'text-right': titleTextAlign === 'right'}]"
				:style="{color:item.color || textColor || '#333'}"
				>

				<!-- 树形结构 统一展开、收起 -->
				<view v-if="firstCol && isTree" @click.stop="toggleExpand" class="iconfont toggle-btn"
					:class="isOpenAll ? 'icon-shouqi' : 'icon-zhankailie'" style="padding: 0 10rpx;color: #0066CC;">
				</view>

				<!-- 内容 -->
				<view class="" v-html="getTitleText(item)"></view>

				<!-- 排序 -->
				<view v-if="item.sort && item[colKey]" class="sort">
					<view class="icon-arrow iconfont icon-shangjiantou"
						:style="{ color: item.color || textColor || '#333'}"
						:class="{ action: nowSortKey == item[colKey] && sortType == 'asc' }"></view>
					<view class="icon-arrow iconfont icon-xiajiantou"
						:style="{ color: item.color || textColor || '#333'}"
						:class="{ action: nowSortKey == item[colKey] && sortType == 'desc' }"></view>
				</view>
			</view>
		</view>

		<view v-if="item.children && item.children.length" style="width: 100%;" class="sub-item">
			<title-column
				v-for="(item1,index) in item.children"
				:item="item1"
				:key="index"
				:nowSortKey="nowSortKey"
				:sortType="sortType"
				:colKey="colKey"
				:textColor="textColor"
				:height="height"
				:fontSize="fontSize"
				:bg="bg"
				:border="border"
				:borderColor="borderColor"
				@sort="handleSort(item1)"
				:titleTextAlign="item1.titleTextAlign || titleTextAlign">
			</title-column>
		</view>
	</view>
</template>

<script>
	// #ifdef MP
	import titleColumn from "./title-column.vue"
	// #endif
	export default {
		name: 'titleColumn',
		// #ifdef MP
		components: { titleColumn },
		// #endif
		props: {
			colKey: { type: String, default: 'id' },
			firstCol: { type: Boolean, default: false },
			isOpenAll: { type: Boolean, default: false, },
			item: { type: Object, default: () => {} },
			titleTextAlign: { type: String, default: 'center' },
			// 是否固定左侧
			stickSide: { type: Boolean, default: false },
			// 当前排序建
			nowSortKey: { type: String, default: "" },
			// 排序方式
			sortType: { type: String, default: '' },
			// 是否树形数据
			isTree: { type: Boolean, default: false },
			height: { type: Number, default: 32 },
			fontSize: { type: [Number, String], default: 14 },
			textColor: { type: String, default: '#333333' },
			bg: { type: String, default: '#f3f4f6' },
			border: { type: Boolean, default: true},
			borderColor: { type: String, default: '#dbdbdb'}
		},

		computed: {
			itemStyle() {
				let { width, children } = this.item
				width = width || 100
				if (typeof width != "number") {
					width = 100
				}
				let height = this.height + 'px'
				let lineHeight = this.height + 'px'
				if (children && children.length) {
					width = children.length * width
				}
				return { width: width + 'px', height, lineHeight, fontSize: this.fontSize + 'px' }
			}
		},
		methods: {
			// 增加别名配置 2022年3月29日
			getTitleText(item) {
				let title = item.customName || item.title
				// 自定义表头
				let tempHTML = title
				return tempHTML.toString()
			},
			handleSort(item) {
				if (!item[this.colKey] || !item.sort) return
				this.$emit('sort', item)
			},
			toggleExpand() {
				this.$emit('toggleTree', this.isOpenAll)
			},
		}
	}
</script>

<style lang="scss" scoped>
	@import "./iconfont.scss";
	@import "./common.scss";

	// 三角形
	%triangle-basic {
		content: '';
		height: 0;
		width: 0;
		overflow: hidden;
	}

	@mixin triangle($direction, $size, $borderColor) {
		@extend %triangle-basic;

		@if $direction==top {
			border-bottom: $size solid $borderColor;
			border-left: $size dashed transparent;
			border-right: $size dashed transparent;
			border-top: 0;
		}

		@else if $direction==right {
			border-left: $size solid $borderColor;
			border-top: $size dashed transparent;
			border-bottom: $size dashed transparent;
			border-right: 0;
		}

		@else if $direction==bottom {
			border-top: $size solid $borderColor;
			border-left: $size dashed transparent;
			border-right: $size dashed transparent;
			border-bottom: 0;
		}

		@else if $direction==left {
			border-right: $size solid $borderColor;
			border-top: $size dashed transparent;
			border-bottom: $size dashed transparent;
			border-left: 0;
		}
	}


	.n-table-col-text {
		display: flex;
		width: 100%;
		flex: 1;
		justify-content: flex-start;
		align-content: center;
		box-sizing: border-box;

		&.text-center {
			justify-content: center;
		}

		&.text-right {
			justify-content: flex-end;
		}
	}

	.title-column-item {
		height: 100%;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		box-sizing: border-box;
		min-width: 100px;
	}

	.sub-item {
		display: flex;

		.title-column-item:last-of-type {
			flex: 1;
		}
	}

	.n-table-title-item {
		box-sizing: border-box;
		width: 100%;
		flex: 1;
		display: flex;
		align-items: center;
	}

	.sort {
		display: flex;
		padding: 5rpx;
		flex-direction: column;
		justify-content: center;

		.up-arrow {
			@include triangle(top, 10rpx, #ccc);
			display: block;
			margin-bottom: 5rpx;

			&.action {
				@include triangle(top, 10rpx, #4298f7);
			}
		}

		.down-arrow {
			@include triangle(bottom, 10rpx, #ccc);
			display: block;

			&.action {
				@include triangle(bottom, 10rpx, #4298f7);
			}
		}
	}

	.toggle-btn {
		position: absolute;
		left: 0;
		top: 50%;
		transform: translateY(-50%);
	}
	.icon-arrow{
		opacity: .5;
		font-size: 12px;
		line-height: 1;
		transform: scale(.9);
		&::after{
			line-height: 1;
		}
		&.action{
			opacity: 1;
		}
	}
</style>
