<template>
	<view class="n-table"
		:style="{
			height: computedHeight.height,
			minHeight: computedHeight.minHeight
		}">
		<!-- 表格标题 -->
		<!-- <table-name v-if="_nameOpt.isShow" :opt="_nameOpt" @menuClick="onMenuClick"></table-name> -->
		<view class="n-table-main"
			:style="{
				height: computedTableHeight.height,
				minHeight: computedTableHeight.minHeight
			}">
			<view v-if="!tableLoaded && (!dataList || !columns) && showLoading" class="ztableLoading n-loading">
				<view class="n-loading-animate"></view>
			</view>
			<view class="n-table-container">
				<view class="n-table-pack">
					<!-- 表头 -->
					<table-header
						:opt="_headerOpt || null"
						:isOpenAll="isOpenAll"
						:columns="columns"
						:stickSide="_tableOpt.stickSide"
						:nowSortKey="nowSortKey"
						:sortType="sortType"
						:colKey="colKey"
						:isTree="isTree"
						:border="_headerOpt.border"
						:borderColor="_headerOpt.borderColor"
						@rowSort="onRowSort"
						@toggleTree="onToggleTree"></table-header>

					<table-body
						:isOpenAll="isOpenAll"
						:isShowSum="_tableOpt.isShowSum"
						:stickSide="_tableOpt.stickSide"
						:dataIndexs="dataIndexs"
						:textAlign="_tableOpt.textAlign || ''"
						:fontSize="_tableOpt.fontSize"
						:color="_tableOpt.color || ''"
						:bold="_tableOpt.bold || false"
						:idKey="idKey"
						:colKey="colKey"
						:isTree="isTree"
						:default-open="defaultOpen"
						:isGroup="isGroup"
						:borderLeft="_tableOpt.borderLeft"
						:borderBottom="_tableOpt.borderBottom"
						:borderColor="_tableOpt.borderColor"
						:sumBg="_tableOpt.sumBg"
						:sumBold="_tableOpt.sumBold"
						:sumTxColor="_tableOpt.sumTxColor"
						:hasPermiArr="hasPermiArr"
						:iconsButStyle="iconsButStyle"
						:showButton="showButton"
						@toggleTree="onToggleTree"
						@onClick="onColClick"
						@editButton="editButton"
						@addButton="addButton"
						@deleteButton="deleteButton"
						@customButton="customButton"
						@customButton2="customButton2"
						:dataList="dataList">
					</table-body>
				</view>
			</view>
			<view v-if="tableLoaded && !dataList.length" class="table-empty">
				<view v-html="_tableOpt.emptyText"></view>
			</view>
		</view>
		<!-- 内部分页处理 -->
		<pager
			v-if="_pagerOpt.show && isPageInner"
			:curPage="innerCurPage"
			:totalPage="innerTotalPage"
			:btnFontSize="_pagerOpt.btnFontSize"
			:btnFontColor="_pagerOpt.btnFontColor"
			:btnFontBold="_pagerOpt.btnFontBold"
			:numFontSize="_pagerOpt.numFontSize"
			:numFontColor="_pagerOpt.numFontColor"
			:numFontBold="_pagerOpt.numFontBold"
			:btnCustomClass="_pagerOpt.btnCustomClass"
			@nextPage="nextPage"
			@prevPage="prevPage"></pager>
		<!-- 外部分页处理 -->
		<pager v-if="_pagerOpt.show && !isPageInner"
			:curPage="currentPage"
			:totalPage="totalPage"
			:btnFontSize="_pagerOpt.btnFontSize"
			:btnFontColor="_pagerOpt.btnFontColor"
			:btnFontBold="_pagerOpt.btnFontBold"
			:numFontSize="_pagerOpt.numFontSize"
			:numFontColor="_pagerOpt.numFontColor"
			:numFontBold="_pagerOpt.numFontBold"
			:btnCustomClass="_pagerOpt.btnCustomClass"
			@nextPage="nextPage"
			@prevPage="prevPage"></pager>
	</view>
</template>

<script>
	import tableHeader from "./table-header.vue"
	import tableBody from "./table-body.vue"
	import tableName from "./table-name.vue"
	import pager from "./pager.vue"
	import { defaultTableOpt, defaultNameOpt, defaultPagerOpt, defaultHeaderOpt } from "./config.js"
	import { sortList } from "./utils.js"
	export default {
		components: { tableHeader, tableBody, tableName, pager },
		data() {
			return {
				nowSortKey: '',
				sortType: 'desc', // asc/desc 升序/降序
				dataList: [], // 遍历显示的数据列表
				saveDataList: [], // 处理后的数据列表 - 用以备份 ： 当分页形式无需重新计算
				dataIndexs: [], // 
				isTree: false, // 是否树形数据
				isOpenAll: false, // 是否展开全部
				innerCurPage: 1, // 当前页码
				innerTotalPage: 0, // 总页数
			}
		},
		props: {
			// table-name 配置
			nameOpt: { type: Object, default: () => {} },
			// 表头配置
			headerOpt: { type: Object, default: () => { return {} } },
			// 整体配置
			tableOpt: { type: Object, default: () => {} },
			// 分页配置
			pagerOpt: { type: Object, default: () => { return {} } },
			// 数据源唯一key字段名
			idKey: { type: String, default: 'id' },
			// columns中对应列表数据的 字段名
			colKey: { type: String, default: 'key' },
			// 数据源
			tableData: { type: [Array, Boolean], default: () => { return false } },

			columns: { type: [Array, Boolean], required: true },
			showLoading: { type: Boolean, default: true },
			tableHeight: { type: [Number, Boolean], default: 0 },
			// 是否需要组件内部排序 
			autoSort: { type: Boolean, default: true },

			// 当前页
			currentPage: { type: [Number, Boolean], default: false },
			// 总页数
			totalPage: { type: Number, default: 1 },
			// 是否默认展开全部
			defaultOpen: { type: Boolean, default: false },
			// 是否[分组表格]
			isGroup: { type: Boolean, default: false },
			//拥有的按钮权限数组，需与showButton顺序一致
			hasPermiArr:{ type: Array, default: ['system:role:edit','system:role:remove','system:role:authUser','system:role:dataScope'] },
			//需要展示的按钮的样式,需与showButton顺序一致
			iconsButStyle:{ type: Array, default: ['plus-filled','compose','trash-filled'] },
			//需要展示的按钮
			showButton:{ type: Array, default: ['add','edit','delete'] }
		},

		computed: {
			// 实际表格内容高度(表头+ 表格)
			computedTableHeight() {
				const nameHeight = this._nameOpt.isShow ? 32 : 0
				const pageHeight = this._pagerOpt.show ? 32 : 0
				const headerHeight = this._headerOpt.height
				return {
					height: this.tableHeight ? this.tableHeight - nameHeight - pageHeight + 'px' : '100%',
					minHeight: this.tableHeight ? 'auto' : headerHeight + 60 + 'px'
				}
			},

			// 默认表格配置
			_tableOpt() {
				return Object.assign({ ...defaultTableOpt }, this.tableOpt)
			},

			// 默认表格名称配置
			_nameOpt() {
				return Object.assign({ ...defaultNameOpt }, this.nameOpt)
			},

			_pagerOpt() {
				return Object.assign({ ...defaultPagerOpt }, this.pagerOpt)
			},

			_headerOpt() {
				return Object.assign({ ...defaultHeaderOpt }, this.headerOpt)
			},

			// 判断是内部处理分页还是外部处理
			isPageInner() {
				let isPageInner = typeof this.currentPage == 'boolean'
				return isPageInner
			},
			
			// 计算当前整个表格高度
			computedHeight() {
				const nameHeight = this._nameOpt.isShow ? 32 : 0
				const pageHeight = this._pagerOpt.show ? 32 : 0
				const headerHeight = this.headerOpt.height || 32
				return {
					height: this.tableHeight ? this.tableHeight + 'px' : '',
					minHeight: this.tableHeight ? 'auto' : nameHeight + pageHeight + headerHeight + 60 + 'px'
				}
			},

			// 表格数据是否已经加载
			tableLoaded() {
				let res = typeof this.tableData === 'boolean' ? false : true
				return res
			}
		},

		watch: {
			columns: {
				handler(val) {
					this.fmtColumns(val)
				},
				immediate: true,
				deep: true
			},
			tableData: {
				handler(val) {
					this.innerCurPage = 1
					this.innerTotalPage = 1
					this.fmtDataList(val)
				},
				immediate: true,
				deep:true,
			}
		},

		mounted() {
			this.isOpenAll = this.defaultOpen
		},
		
		methods: {
			nextPage(e) {
				if (this.isPageInner) {
					this.innerCurPage++
					this.fmtDataList(this.saveDataList)
				} else {
					this.$emit('onNextPage', this.currentPage)
				}
			},
			prevPage(e) {
				if (this.isPageInner) {
					this.innerCurPage--
					this.fmtDataList(this.saveDataList)
				} else {
					this.$emit('onPrevPage', this.currentPage)
				}
			},

			// 排序
			onRowSort(option) {
				this.sort(option.sortKey)
			},

			// 根据Column 获取body中实际渲染的列
			fmtColumns(list) {
				this.dataIndexs = []
				if (!list || !list.length) return
				// 获取实际行
				this.columnsDeal(list)
			},

			// 
			columnsDeal(list, level = 0) {
				list.filter(it => !it.Hidden).forEach(item => {
					let { children, ...res } = item
					if (children && children.length) {
						this.columnsDeal(children, level + 1)
					} else {
						this.dataIndexs.push({ ...res })
					}
				})
			},

			// 处理数据列表
			fmtDataList(list) {
				this.isTree = false
				if (!list || !list.length) {
					this.saveDataList = []
					this.dataList = false
					return
				}

				// 保留一份完整数据
				let _list = JSON.parse(JSON.stringify(list))
				this.saveDataList = list
				
				// 分组只显示有children 的
				if(this.isGroup) _list = _list.reduce((ls,item)=>{
					return item.children && item.children.length ? ls.concat(item) : ls
				},[])
				
				let dataList
				if (this._pagerOpt.show && this.isPageInner ) {
					// 内部处理分页 
					this.innerTotalPage = Math.ceil(_list.length / this._pagerOpt.pageSize)
					dataList = this.getPagerList(_list)
				} else {
					// 不分页
					dataList = _list
				}
				this.dataList = this.isGroup ? this.listFmtGroup(dataList) : this.listFmt(dataList, 0)
				// 计算总计行
				// 分组表格没有 总计行功能
				if (this._tableOpt.isShowSum && !this.isGroup) {
					this.setSumRow()
				}
			},

			// 内部处理分页 
			getPagerList(list) {
				let curPage = this.innerCurPage
				let pageSzie = this._tableOpt.isShowSum && !this.isGroup ? this._pagerOpt.pageSize - 1 : this._pagerOpt.pageSize
				return list.slice((curPage - 1) * pageSzie, curPage * pageSzie)
			},

			// 设置总计行
			setSumRow() {
				let sumItem = {
					[this.idKey]: 'sum-row',
					parentIds: [],
					level: 0,
					hasChildren: false,
					isSum: true,
				}
				this.columns.forEach((item, index) => {
					if (!item.isImage) {
						sumItem[item[this.colKey]] = index === 0 ? '总计' : this.dosum(item)
					}
				})
				if (this._tableOpt.sumPlace === 'top') {
					this.dataList.unshift(sumItem)
				} else {
					this.dataList.push(sumItem)
				}
			},

			// 递归处理数据，tree => Array
			listFmt(list, level, parentIds = []) {
				return list.reduce((ls, item) => {
					let { children, ...res } = item
					// 错误提示
					if (res[this.idKey] === undefined || !res[this.idKey] === null) {
						// console.error(`tableData 数据中存在 [idKey] 属性不存在数据，请检查`)
					}
					let nowItem = {
						...res,
						level,
						hasChildren: children && children.length,
						parentIds,
						children,
						[this.idKey]: res[this.idKey] && res[this.idKey].toString()
					}
					ls.push(nowItem)
					if (children && children.length) {
						this.isTree = true
						ls = ls.concat(this.listFmt(children, level + 1, [...parentIds, nowItem[this.idKey]]))
					}
					return ls
				}, [])
			},

			// 格式化
			listFmtGroup(list) {
				return list.reduce((ls, item) => {
					return ls.concat({ ...item, open: item.open || false })
				}, [])
			},

			getPageSize(selecter) {
				// 获取元素信息
				let query = uni.createSelectorQuery().in(this),
					_this = this
				return new Promise((resolve, reject) => {
					query
						.select(selecter)
						.boundingClientRect(res => {
							resolve(res)
						})
						.exec()
				})
			},

			dosum({ noSum = false, formatNum = false, ...row }) {
				let key = row[this.colKey]
				let sum = '-'
				if (noSum) return sum
				if (this.dataList) {
					if (
						this.dataList.every(item => {
							return !Number.isNaN(item[key] - 0)
						})
					) {
						sum = 0
						this.dataList.map((item, index) => {
							if (!key && index != 0) {
								sum = '-'
							} else {
								let val = item[key] - 0
								if (Number.isNaN(val)) {
									sum += 0
								} else {
									sum += val
								}
							}
						})
					}
				}
				return formatNum ? this.numTransform(sum) : sum
			},

			numTransform(n) {
				if (Number.isNaN(n - 0)) {
					return n
				}
				if (Math.abs(n) >= 100000000) {
					n = Number((n / 100000000).toFixed(1)) + '亿'
				} else if (Math.abs(n) >= 10000) {
					n = Number((n / 10000).toFixed(1)) + '万'
				}
				return n.toString()
			},

			sort(key, index) {
				if (!key) { return }
				// 排序功能: 如果点击的排序按钮是原先的 那么更改排序类型
				// 如果点击的另一个排序按钮 那么选择当前排序并且排序类型改为降序(desc)
				if (key != this.nowSortKey) {
					this.nowSortKey = key
					this.sortType = 'desc'
				} else {
					this.toggleSort()
				}

				this.$emit('onSort', { sortKey: this.nowSortKey, sortType: this.sortType })

				// 组件内部自动排序
				if (!this.autoSort) return
				let res = sortList({
					list: JSON.parse(JSON.stringify(this.tableData)),
					sortBy: this.nowSortKey,
					sortOrder: this.sortType
				})
				this.fmtDataList(res)
			},

			// 更改排序类型
			toggleSort() {
				this.sortType = this.sortType == 'asc' ? 'desc' : 'asc'
			},

			resetSort() {
				// 重置排序状态
				this.nowSortKey = ''
				this.sortType = 'desc'
			},

			// 点击表格行
			onColClick(row, col) {
				this.$emit('onClick', row, col)
			},

			// 展开/ 收起树形结构
			onToggleTree(oldStatus) {
				this.isOpenAll = !oldStatus
			},

			// 点击表头右侧菜单
			onMenuClick() {
				if (this._nameOpt.needMenu) {
					this.$emit('clickMenu')
				}
			},
			//新增按钮操作
			addButton(row, col){
				this.$emit('addButton', row, col)
			},
			//编辑按钮操作
			editButton(row, col){
				this.$emit('editButton', row, col)
			},
			//删除按钮操作
			deleteButton(row, col){
				this.$emit('deleteButton', row, col)
			},
			//操作列，自定义按钮
			customButton(row, col){
				this.$emit('customButton',row,col)
			},
			//操作列，自定义按钮
			customButton2(row, col){
				this.$emit('customButton2',row,col)
			}
		}
	}
</script>

<style lang="scss">
	@import "./common.scss";

	.n-table-main {
		// position: relative;
	}

	.navigator-hover {
		background: transparent;
		opacity: 1;
	}

	a {
		text-decoration: none;
	}

	.n-table {
		position: relative;
		display: inline-block;
		height: 100%;
		min-height: 130rpx;
		width: 100%;
		background: #fff;
		font-size: $uni-font-size-sm;
		box-sizing: border-box;
		transform: translateZ(0);

		.n-table-main {
			height: 100%;
			box-sizing: border-box;
		}

		.n-table-container {
			height: 100%;
			overflow: scroll;
			box-sizing: border-box;
		}

		.n-table-pack {
			position: relative;
			min-height: 100%;
			min-width: 100%;
			width: fit-content;
		}

		.table-empty {
			position: absolute;
			top: 0;
			left: 0;
			z-index: 0;
			display: flex;
			align-items: center;
			justify-content: center;
			border: none;
			height: 100%;
			width: 100%;
			background: transparent;
			pointer-events: none;
			color: #999
		}

		// 1.0.5
		.n-loading {
			position: absolute;
			top: 0;
			left: 0;
			z-index: 114;
			display: flex;
			align-items: center;
			justify-content: center;
			border: none;
			height: 100%;
			width: 100%;
			background: transparent;
			opacity: 0;
			transition: all 0.3s;

			&.ztableLoading {
				opacity: 1;
			}

			.n-loading-animate {
				position: relative;
				display: inline-block;
				width: 30rpx;
				height: 30rpx;
				margin-right: 20rpx;
				border-radius: 100%;
				border: solid 6rpx #00aaff;
				vertical-align: middle;
				animation: rotate 1s linear infinite;

				&::after {
					content: '';
					display: block;
					position: absolute;
					top: -10rpx;
					z-index: 1;
					background: #fff;
					width: 20rpx;
					height: 20rpx;
					border-radius: 10rpx;
				}
			}

			@keyframes rotate {
				from {
					transform: rotate(0deg);
				}

				to {
					transform: rotate(360deg);
				}
			}
		}

		.select-box {
			display: inline-block;
			width: 26rpx;
			height: 26rpx;
			line-height: 14rpx;
			margin-right: 15rpx;
			border: solid 2rpx #4298f7;
			border-radius: 4rpx;
			background: #fff;
			text-align: center;
		}

		.select-tip {
			display: inline-block;
			opacity: 0;
			transform: rotate(90deg);
			transition: all .3s;

			&.selected {
				position: relative;
				top: 4rpx;
				left: -4rpx;
				height: 4rpx;
				background: #4298f7;
				width: 10rpx;
				opacity: 1;
				transform: rotate(45deg);

				&:before,
				&:after {
					content: '';
					position: absolute;
					display: block;
					height: 4rpx;
					background: #4298f7;
				}

				&:before {
					bottom: -2rpx;
					left: -4rpx;
					width: 8rpx;
					transform: rotate(-90deg);
				}

				&:after {
					bottom: 16rpx;
					right: -16rpx;
					width: 34rpx;
					transform: rotate(-90deg);
				}
			}
		}

	}
</style>
