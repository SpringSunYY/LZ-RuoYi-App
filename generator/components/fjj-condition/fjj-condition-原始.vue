<template>
	<view>
		<!-- <uni-drawer :visible="visibleDrawer" :hideNoAnimate="showBackButton" mode="left" @close="closeDrawer()"> -->
		<uni-popup ref="popup" background-color="#fff">
			<!-- <view class="popup-content" :class="{ 'popup-height': popupType === 'left' || popupType === 'right' }"> -->
				<!-- <text class="text"> -->
			<!-- #ifdef APP-PLUS -->
			<!-- <view class="iconfont icon-guanbi" v-if="showBackButton" @tap="closeDrawer()"></view> -->
			<!-- #endif -->
			<scroll-view class="drawer-list" scroll-y :style="{'height': drawerHeight, 'padding-top': fixTop}">
				<block v-for="(item, index) in menuList" :key="index">
					<!-- 单选、多选  isMutiple是否支持多选-->
					<view v-if="item.type === 'custom' && item.detailList.length">
						<view class="drawer-list-title flex justify-between">
							<view>
								{{item.title}}
							</view>
							<text v-if="item.detailList.length>showLenght"
								@tap="showMore(index)">{{item.showMoreList ? '收起' : '更多'}}</text>
						</view>
						<view class="draer-list-con">
							<template v-if="!item.showMoreList">
								<text
									:style="{background: textItem.isSelected ? color : '', color:  textItem.isSelected ? '#ffffff' : ''}"
									v-if="idx<showLenght" v-for="(textItem, idx) in item.detailList" :key="idx"
									:class="textItem.isSelected ? 'on' : ''"
									@tap="itemTap(idx,item.detailList,item.key, item.isMutiple)">
									{{textItem.title}}
								</text>
							</template>
							<template v-else>
								<text
									:style="{background: textItem.isSelected ? color : '', color:  textItem.isSelected ? '#ffffff' : ''}"
									v-for="(textItem, idx) in item.detailList" :key="idx"
									:class="textItem.isSelected ? 'on' : ''"
									@tap="itemTap(idx,item.detailList,item.key, item.isMutiple)">
									{{textItem.title}}
								</text>
							</template>
						</view>
					</view>
					<!-- 时间带时分秒范围选择 -->
					<view v-if="item.type === 'rangetime'">
						<view class="drawer-list-title flex justify-between">
							<view>
								{{item.title}}
							</view>
						</view>
						<view class="dateContent" @click="onShowDatePicker('rangetime', item.key, item)">
							<view>
								<template v-if="result[item.key] && result[item.key].length > 0">
									{{result[item.key][0]}}
								</template>
							</view>
							<view>
								<template v-if="result[item.key] && result[item.key].length > 0">
									{{result[item.key][1]}}
								</template>
							</view>
						</view>
					</view>
					<!-- 时间不带时分秒范围选择 -->
					<view v-if="item.type === 'range'">
						<view class="drawer-list-title flex justify-between">
							<view>
								{{item.title}}
							</view>
						</view>
						<view class="dateContent" @click="onShowDatePicker('range', item.key, item)">
							<view>
								<template v-if="result[item.key] && result[item.key].length > 0">
									{{result[item.key][0]}}-{{result[item.key][1]}}
								</template>
							</view>
						</view>
					</view>
					<!-- 时间选择 -->
					<view v-if="item.type === 'date'">
						<view class="drawer-list-title flex justify-between">
							<view>
								{{item.title}}
							</view>
						</view>
						<view class="dateContent" @click="onShowDatePicker('date', item.key, item)">
							<view>
								<template v-if="result[item.key]">
									{{result[item.key]}}
								</template>
							</view>
						</view>
					</view>
					<!-- 数值范围选择 -->
					<view v-if="item.type === 'rangenumber'">
						<view class="drawer-list-title flex justify-between">
							<view>
								{{item.title}}
							</view>
						</view>
						<view class="dateContent rangenumber-content flex">
							<view class="rangenumber-input">
								<input class="m-input" type="number" clearable v-model="result[item.minName || (item.key + 'Min')]"
									:placeholder="item.minPlaceholder || '最小值'"
									@blur="numberInputBlur(item)"></input>
							</view>
							<text>-</text>
							<view class="rangenumber-input">
								<input class="m-input" type="number" clearable v-model="result[item.maxName || (item.key + 'Max')]"
									:placeholder="item.maxPlaceholder || '最大值'"
									@blur="numberInputBlur(item)"></input>
							</view>
						</view>
					</view>
					<!-- 单输入框 -->
					<view v-if="item.type === 'singleinput'">
						<view class="drawer-list-title flex justify-between">
							<view>
								{{item.title}}
							</view>
						</view>
						<view class="dateContent">
							<view>
								<input class="m-input" clearable v-model="result[item.key]"
									:placeholder="item.placeholder || '请输入关键字'" />
							</view>
						</view>
					</view>
				</block>
			</scroll-view>
			<view class="filter-content-footer flex justify-center">
				<!-- #ifdef APP-PLUS-->
				<!-- <view v-if="showBackButton" class="filter-content-footer-item" :style="{color: '#ccc', 'border': '1rpx solid #ccc'}"
					@tap="closeDrawer()">
					<text>返回</text>
				</view> -->
				<!-- #endif -->
				<view class="filter-content-footer-item" :style="{color, 'border': `1rpx solid ${color}`}"
					@tap="resetClick">
					<text>重置</text>
				</view>
				<view class="filter-content-footer-item" :style="{'background': color}" @tap="sureClick">
					<text>确认</text>
				</view>
			</view>
			<!-- </text> -->
					<!-- </view> -->
			</uni-popup>
		<!-- </uni-drawer> -->
		<mx-date-picker :show="showPicker" :color="color" :type="dateType" :value="dateValue" :show-tips="true"
			:show-seconds="true" @confirm="onSelected" @cancel="onSelected" />
	</view>
</template>

<script>
	/***
	 * 筛选组件，当前支持多选、单选
	 * item.type (custom 单选、多选、rangetime 时间范围带时分秒、range 时间范围不带时分秒、rangenumber 数字范围)
	 * item.isMutiple 是否支持多选
	 * 筛选后返回格式{"listName1":[value,value](多选),"listName2":"value"（单选）,...}
	 * rangenumber形式-可能为["",1]或[1,""]表示只有一个最大值或最小值
	 ***/
	import uniDrawer from '@/components/uni-drawer/fjj-uni-drawer.vue';
	import MxDatePicker from "@/components/mx-datepicker/mx-datepicker.vue";
	export default {
		props: {
			list: {
				required: true,
				type: Array,
				default () {
					return [];
				},
			},
			color: {
				type: String,
				default: '#4D7BFE',
			},
			defaultValue: { //若有默认值则触发sureClick
				type: Object,
				default () {
					return {}
				},
			},
			// showBackButton: {
			// 	type: Boolean,
			// 	default: false,
			// }
		},
		watch: {
			 list: {
				 handler(val) {
					  this.menuList = JSON.parse(JSON.stringify(val));
						this.resetResult();
						this.defaultValueFun();
				},
				deep: true  // 可以深度检测到 obj 对象的属性值的变化	
			 },
		},
		components: {
			uniDrawer,
			MxDatePicker
		},
		beforeCreate() {
			Object.isEmpty = (object, except = []) => {
				if (!object) {
					return false;
				}
				for (let key in object) {
					if (except && except.includes(key)) {
						continue;
					}
					if (object.hasOwnProperty(key)) {
						return false;
					}
				}
				return true;
			};
			Date.prototype.Format = function(fmt) { //author: meizz
				var o = {
					"M+": this.getMonth() + 1, //月份 
					"d+": this.getDate(), //日 
					"h+": this.getHours(), //小时 
					"m+": this.getMinutes(), //分 
					"s+": this.getSeconds(), //秒 
					"q+": Math.floor((this.getMonth() + 3) / 3), //季度 
					"S": this.getMilliseconds() //毫秒 
				};
				if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1
					.length));
				for (var k in o)
					if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[
						k]) : (("00" + o[
						k]).substr(("" + o[k]).length)));
				return fmt;
			};
			String.prototype.replaceAll = function(oldValue, newValue) { return this.toString().replace(new RegExp(oldValue, 'gm'), newValue); }
		},
		created() {
			this.menuList = JSON.parse(JSON.stringify(this.list));
			this.resetResult();
			uni.getSystemInfo({
				success: (res) => {
					let windowHeight = res.windowHeight;
					// #ifdef H5
					if (!(this.$IsWeixin || this.$IsAlipay || this.$IsCloudPay)) {
						let thirdApp = getApp().globalData.options?.thirdApp;
						  if (thirdApp && thirdApp.hideNavBar) {
						    // 第三方App使用App原生导航栏
						  } else {
						    this.fixTop = (res.statusBarHeight || 0) + 'px';
						  }
					}
					windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body
						.clientHeight || res.windowHeight;
					// #endif
					this.drawerHeight = (windowHeight - uni.upx2px(350)) + 'px';
					// uni.showModal({
					// 	content: `model: ${res.model}`,
					// })
				}
			});
		},
		mounted() {
			this.defaultValueFun();
		},
		computed: {
		},
		data() {
			return {
				popupType: 'center',
				menuList: [],
				visibleDrawer: false,
				menuKey: 1,
				showLenght: 6,
				drawerHeight: '500px',
				selectDetailList: [],
				result: {},
				showPicker: false,
				dateType: 'rangetime',
				dateValue: '',
				fixTop: '0px'
			};
		},

		methods: {
			//打开弹窗
			openPopup(){
				// 通过组件定义的ref调用uni-popup方法 ,如果传入参数 ，type 属性将失效 ，仅支持 ['top','left','bottom','right','center']
				this.$refs.popup.open('top')
			},
			//关闭弹窗
			closePopup(){
				this.$refs.popup.close();
			},
			defaultValueFun() {
				//如果有默认值，则赋值后调用sureClick通知父组件更新
				if (!Object.isEmpty(this.defaultValue)) {
					const value = this.defaultValue;
					const list = JSON.parse(JSON.stringify(this.menuList));
					for (let key in value) {
						for (let i = 0; i < list.length; i++) {
							if (list[i].key === key) {
								if (list[i].type === 'custom') {
									list[i].detailList.map((item, index) => {
										if (Array.isArray(value[key]) && value[key].indexOf(item.value) > -1) {
											item.isSelected = true;
										} else if (value[key] == item.value) {
											item.isSelected = true;
										}
										return item;			
									})
									continue;
								}
								if (list[i].type === 'range' || list[i].type === 'rangetime' || list[i].type === 'rangenumber' && Array.isArray(value[key]) && value[key].length === 2) {
										this.result[key] = value[key];
										this.result[list[i].minName || (list[i].key + 'Min')] = value[key][0];
										this.result[list[i].maxName || (list[i].key + 'Max')] = value[key][1];
										continue;
								}
								if (list[i].type === 'date' || list[i].type === 'singleinput' && value[key]) {
										this.result[key] = value[key];
										continue;
								}
							}
						}
					}
					if (this.defaultRefeshTimer) {
						clearTimeout(this.defaultRefesh·Timer);
					}
					this.defaultRefeshTimer = setTimeout(() => {
						console.log('筛选默认值触发')
						this.menuList = list;
						this.sureClick();
					}, 200);
				}
			},

			resetResult() {
				this.result = this.commonResultObj();
			},
			commonResultObj() {
				let obj = {};
				this.menuList.map((item) => {
					switch(item.type) {
						case "custom":
							item.isMutiple ? obj[item.key] = [] : obj[item.key] = '';
							item.detailList.forEach(dListItem => {
								dListItem.isSelected = dListItem.isSelected || false;
							});
							break;
						case 'range':
						case 'rangetime':
						case 'rangenumber':
							this.result[item.key] = [];
							this.result[item.minName || (item.key + 'Min')] = '';
							this.result[item.maxName || (item.key + 'Max')] = '';
							break;
						default:
							obj[item.key] = '';
					}
				})
				return obj;
			},
			//筛选项选中或取消
			itemTap(index, list, key, isMutiple) {
				if (isMutiple == true) {
					list[index].isSelected = !list[index].isSelected;
					if (list[index].isSelected) {
						this.result[key].push(list[index].value);
					} else {
						list[index].isSelected = false;
						var idx = this.result[key].indexOf(list[index].value);
						this.result[key].splice(idx, 1);
					}
				} else {
					this.result[key] = list[index].isSelected ? '' : list[index].value;
					for (let i = 0; i < list.length; i++) {
						if (index == i && !list[i].isSelected) {
							list[i].isSelected = true
						} else {
							list[i].isSelected = false
						}
					}
				}

				// #ifdef H5 || APP-PLUS
				this.$forceUpdate();
				// #endif
			},

			sureClick() {
			    this.menuList.forEach(menu => {
					let list = menu.detailList || [];
					if (menu.type == 'custom' && list.length > 0) {
						let selectedValueList = [];
						list.forEach(item => {
							if (item.isSelected) {
								selectedValueList.push(item.value);
							}
						});
						
						if (menu.isMutiple == true) {
							this.result[menu.key] = selectedValueList;
						} else {
							this.result[menu.key] = selectedValueList[0] || '';
						}
					}
				});
				
				let str_result = {};
				let hasChoose = false;//筛选面板用户是否选择值
				for (let key in this.result) {
					if (typeof this.result[key] == 'object') {
						str_result[key] = this.result[key].join(',');
						if (!hasChoose) {
							hasChoose = this.result[key].join(',') !== '' ? true : false;
						}
					} else {
						str_result[key] = this.result[key];
						if (!hasChoose) {
							hasChoose = this.result[key] !== '' ? true : false;
						}
					}
				}

				this.$emit("result", {
					'str_result': str_result,
					'result': this.result,
					'hasChoose': hasChoose,
					'visibleDrawer': false
				});
				//关闭弹窗
				this.closePopup();
			},
			//重置参数
			resetClick() {
				this.minNumber = '';
				this.maxNumber = '';
				for (let key in this.result) {
					if (typeof this.result[key] === 'object') {
						this.result[key] = [];
					} else {
						this.result[key] = '';
					}
				}
				for (let i = 0; i < this.menuList.length; i++) {
					if (this.menuList[i].type === 'custom') {
						for (let j = 0; j < this.menuList[i].detailList.length; j++) {
							this.menuList[i].detailList[j].isSelected = false;
						}
					}
				}
				// #ifdef H5 || APP-PLUS
				this.$forceUpdate();
				// #endif
			},
			// closeDrawer() {
			// 	this.visibleDrawer = false;
			// 	// #ifdef APP-PLUS
			// 	this.$emit("result", {
			// 		type: 1,
			// 	});
			// 	// #endif
			// },

			showMore(index) {
				this.menuList[index].showMoreList = !this.menuList[index].showMoreList;
				++this.menuKey;
				// #ifdef H5 || APP-NVUE
				this.$forceUpdate();
				// #endif
			},

			onShowDatePicker(type, key, item) { //显示
				this.dateType = type;
				this.dateValue = this.result[key] || '';
				this.showPicker = true;
				this.tempKey = key;
				this.item = item;
			},

			onSelected(e, key) { //选择
				this.showPicker = false;
				if (e) {
					this.result[this.tempKey] = e.value;
					if (e.value && e.value.length && this.item && this.item.type !== 'date') {
						let item = this.item;
						this.result[item.minName || (item.key + 'Min')] = e.value[0].replaceAll('/', '-');
						this.result[item.maxName || (item.key + 'Max')] = e.value[1].replaceAll('/', '-');
					}
					//选择的值
					console.log('value => ' + e.value);
					//原始的Date对象
					console.log('date => ' + e.date);
				}
			},

			numberInputBlur(item) {
				let minNumber = this.result[item.minName || (item.key + 'Min')];
				let maxNumber = this.result[item.maxName || (item.key + 'Max')];
				if (minNumber != '' && maxNumber != '' && parseFloat(minNumber) > parseFloat(maxNumber)) {
					let temp = minNumber;
					this.result[item.minName || (item.key + 'Min')] = maxNumber;
					this.result[item.maxName || (item.key + 'Max')] = temp;
				}
				this.result[item.key] = [];
				this.result[item.key].push(minNumber && parseFloat(minNumber));
				this.result[item.key].push(maxNumber && parseFloat(maxNumber));
			}
		}
	}
</script>

<style lang="scss" scoped>
	.flex {
		display: flex;
	}

	.justify-between {
		justify-content: space-between;
	}

	view,
	scroll-view,
	swiper,
	button,
	input,
	textarea,
	label,
	navigator,
	image {
		box-sizing: border-box;
	}

	/* 筛选样式 */
	.drawer-list {
		padding: 0 20rpx;
		font-size: 26rpx;
	}

	input {
		font-size: 26rpx;
	}

	.drawer-list .drawer-list-title {
		font-size: 34rpx;
		font-weight: 400;
		line-height: 48rpx;
		margin: 38rpx 0 18rpx;
		color: rgba(34, 34, 34, 1);
	}

	.drawer-list .drawer-list-title>text {
		font-size: 26rpx;
		color: #666666;
	}

	.drawer-list .draer-list-con>text {
		background: rgba(93, 92, 254, 0.1);
		border-radius: 28px;
		color: #666666;
		font-size: 28rpx;
		padding: 10rpx 28rpx;
		margin: 10rpx 10rpx 10rpx 0;
		display: inline-block;
	}

	.filter-content-footer-item {
		flex: 1;
		height: 72rpx;
		line-height: 72rpx;
		text-align: center;
		border-radius: 8rpx;
		margin: 14rpx;
		color: #FFFFFF;

	}

	.picker {
		z-index: 99999 !important;
	}

	.dateContent {
		&>view {
			background: rgba(244, 244, 244, 1);
			border-radius: 8rpx;
			width: 100%;
			height: 64rpx;
			line-height: 64rpx;
			margin-bottom: 12rpx;
			padding: 0 12rpx;
		}
	}

	.rangenumber-content {
		&>text {
			display: inline-block;
			width: 10%;
			text-align: center;
			height: 64rpx;
			line-height: 64rpx;
		}

		.rangenumber-input {
			width: 45%;
			display: inline-block;
			padding: 0 12rpx;
		}
	}

	.m-input {
		height: 64rpx;
		line-height: 64rpx;
	}

	::v-deep .picker {
		z-index: 999;
	}
	// .icon-guanbi {
	// 	position: fixed;
	// 	top: 40rpx;
	// 	right: 40rpx;
	// 	z-index: 1000;
	// }
	
	
	
	// @mixin flex {
	// 		/* #ifndef APP-NVUE */
	// 		display: flex;
	// 		/* #endif */
	// 		flex-direction: row;
	// 	}
	
	// @mixin height {
	// 	/* #ifndef APP-NVUE */
	// 	height: 100%;
	// 	/* #endif */
	// 	/* #ifdef APP-NVUE */
	// 	flex: 1;
	// 	/* #endif */
	// }
	// .popup-content {
	// 		@include flex;
	// 		align-items: center;
	// 		justify-content: center;
	// 		padding: 15px;
	// 		height: 600px;
	// 		background-color: #fff;
	// 	}
	// .popup-height {
	// 	@include height;
	// 	width: 600px;
	// }
</style>
