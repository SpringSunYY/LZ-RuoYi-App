<template>
	<view>
		<view class="uni-select" @click="dropdownTreeClick">
			<input v-model="inputLabel" placeholder="请选择" class="uni-select__input-text" />
			<uni-icons :type="dropdownTreeShow? 'top' : 'bottom'" size="14" color="#999" />
		</view>
		<view class="uni-select__selector" v-show="dropdownTreeShow">
			<view class="uni-popper__arrow"></view>
		  <dropdownTree
			  ref="DropdownTreeRef"
			  :data="dataOptions"
			  :labelField="labelField"
			  :valueField="valueField"
			  :defaultCheckedKeys="defaultCheckedKeys"
			  expandChecked
			  @change="handleTreeChange"
			  ></dropdownTree>
		</view>
		</view>
</template>

<script>
  import dropdownTree from '@/components/cxk-dropdown-tree/dropdownTree.vue'

  export default {
	name: 'cxkDropdownTree',
	components: {
		dropdownTree
	},
	props: {
		value: {//父组件v-model绑定的变量
			type: [String, Number],
			default: ""
		},
		labelField: {
			type: String,
			default: ""
		},
		valueField: {
			type: String,
			default: ""
		},
		defaultCheckedKeys: {
			type: String,
			default: ""
		},
		dataOptions: {
			type: Array,
			default () {
				return []
			}
		},
	},
	model: {
	  // 需要双向绑定的 props 变量名称，也就是父组件通过 v-model 与子组件双向绑定的变量
	  prop: 'value',
	  // 定义由 $emit 传递变量的名称
	  event: 'modelValueEmit'
	},
    data() {
      return {
		dropdownTreeShow: false,
		inputLabel: "",
		modelValue: this.value//接收父组件中传递的v-model绑定的变量
      }
    },
	watch: {
	  // 监听 modelValue 临时变量，如果临时变量发生变化，那么通过 $emit 将新的值传递给父组件
	  modelValue(value) {
		// 【注意】modelValueEmit 需要和 model.event 定义的值一致
		this.$emit('modelValueEmit', this.modelValue)
	  }
	},
	mounted() {
		// this.defaultValueEcho();
	},
    methods: {
	  //点击选中节点复选框事件
	  handleTreeChange(values, currentItem) {
		this.inputLabel = currentItem.label;
		this.$emit('change', values, currentItem);
		this.dropdownTreeShow=false;
		this.modelValue=values;//子组件变量发生变化，会触发监听，将子组件变化的值传递给父组件的v-model绑定的变量
	  },
	  //点击选择
	  dropdownTreeClick(){
		  this.dropdownTreeShow=!this.dropdownTreeShow;
	  },
    }
  }
</script>

<style lang="scss">
/* 下拉树样式开始 */
.uni-select__selector {
	/* #ifndef APP-NVUE */
	box-sizing: border-box;
	/* #endif */
	position: absolute;
	top: calc(100% + 12px);
	left: 0;
	width: 100%;
	background-color: #FFFFFF;
	border: 1px solid #EBEEF5;
	border-radius: 6px;
	box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
	z-index: 3;
	padding: 4px 0;
}
.uni-popper__arrow,
.uni-popper__arrow::after {
	position: absolute;
	display: block;
	width: 0;
	height: 0;
	border-color: transparent;
	border-style: solid;
	border-width: 6px;
}
.uni-popper__arrow {
	filter: drop-shadow(0 2px 12px rgba(0, 0, 0, 0.03));
	top: -6px;
	left: 10%;
	margin-right: 3px;
	border-top-width: 0;
	border-bottom-color: #EBEEF5;
}
.uni-popper__arrow::after {
	content: " ";
	top: 1px;
	margin-left: -6px;
	border-top-width: 0;
	border-bottom-color: #fff;
}
.uni-select {
	font-size: 14px;
	border: 1px solid #e5e5e5;
	box-sizing: border-box;
	border-radius: 4px;
	padding: 0 5px;
	padding-left: 10px;
	position: relative;
	/* #ifndef APP-NVUE */
	display: flex;
	user-select: none;
	/* #endif */
	flex-direction: row;
	align-items: center;
	border-bottom: solid 1px #e5e5e5;
	width: 100%;
	flex: 1;
	height: 35px;

	&--disabled {
		background-color: #f5f7fa;
		cursor: not-allowed;
	}
}
.uni-select__input-text {
	width: 100%;
	color: #333;
	white-space: nowrap;
	text-overflow: ellipsis;
	-o-text-overflow: ellipsis;
	overflow: hidden;
	font-size: 14px;
}
/* 下拉树样式结束 */
</style>
