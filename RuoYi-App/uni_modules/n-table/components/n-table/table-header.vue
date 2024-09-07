<template>
	<view class="n-table-title">
		<block v-for="(item, index) in columns" :key="index">
			<view class="header-item"
				v-if="!item.hidden"
				:key="index"
				:class="{'header-sticky': stickSide && index === 0}"
				:style="{background:opt.bg, color:opt.color, fontWeight:opt.bold ? 'bold' : 'normal'}">
				<titleColumn
					:isOpenAll="isOpenAll"
					:item="item"
					:height="opt.height"
					:fontSize="opt.fontSize"
					:titleTextAlign="item.titleTextAlign || opt.align"
					:textColor="opt.color"
					:bg="opt.bg"
					:nowSortKey="nowSortKey"
					:sortType="sortType"
					:border="border"
					:borderColor="borderColor"
					@sort="onSort"
					@toggleTree="onToggleTree"
					:isTree="isTree"
					:firstCol="index === 0"
					:colKey="colKey"></titleColumn>
			</view>
		</block>
	</view>
</template>

<script>
	import titleColumn from "./title-column.vue"
	export default {
		name: 'tableHeader',
		components: { titleColumn },
		props: {
			nowSortKey: { type: String, default: '' },
			sortType: { type: String, default: '' },
			colKey: { type: String, default: 'key' },
			isOpenAll: { type: Boolean, default: false },
			isTree: { type: Boolean, default: false },
			border: { type: Boolean, default: true},
			borderColor: { type: String, default: '#dbdbdb'},
			columns: {
				type: [Array, Boolean],
				default: () => []
			},
			stickSide: {
				type: Boolean,
				default: true
			},
			opt: {
				type: Object,
				default: () => {}
			},

		},
		methods: {
			onSort(item) {
				this.$emit('rowSort', {
					sortKey: item[this.colKey]
				})
			},
			// 展开全部/收起全部 树
			onToggleTree(oldStatus) {
				this.$emit('toggleTree', oldStatus)
			},
		}
	}
</script>

<style scoped lang="scss">
	@import "./common.scss";

	.n-table-title {
		position: sticky;
		top: 0;
		left: 0;
		z-index: 9;
		width: 100%;
		display: flex;
		justify-content: flex-start;
	}

	.n-table-title {
		.header-item:last-of-type {
			width: 100%;

			.title-column-item {
				width: 100% !important;
				flex: 1;
			}
		}
	}

	.header-sticky {
		position: sticky;
		left: 0;
		z-index: 9;
	}

	.header-item:last-of-type {
		flex: 1;
	}
</style>
