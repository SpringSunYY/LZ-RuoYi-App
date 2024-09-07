# 使用说明
## 相关功能说明及配置说明


### 全部配置: (`props`) ###
```javascript
export default {
	props:{
		// 表格名称相关配置 ,详细请看本文具体配置
		nameOpt: {type: Object},
		// 表头相关配置 ,详细请看本文具体配置
		headerOpt: { type: Object },
		// 表格基础配置 ,详细请看本文具体配置
		tableOpt: { type: Object },
		// 数据源唯一key字段名
		idKey: { type: String, default: 'id' },
		// columns中对应列表数据的 字段名(例子中对应dataIndex)
		colKey: { type: String, default: 'key' },
		// 数据源 异步加载可以先传递false
		tableData: { type: [Array, Boolean], default () { return false } },
		// 表头数据
		columns: {type: [Array, Boolean], required: true},
		// 初始化是否显示loading
		showLoading: {type: Boolean,default: true},
		// 表格高度 不传递或0表示不限制
		tableHeight: {type: [Number, Boolean],default: 0},
		// 组件内自动排序，默认true
		autoSort： { type: Boolean, default: true},
		// 分页功能相关配置， 详细情况本文具体配置
		pagerOpt: { type: Object },
		// [v1.0.4新增] 当前页 传 false 表示内部处理分页，传Number类型表示外部处理分页，会暴露 上一页、下一页事件
		currentPage: { type: Boolean | Number, default: false},
		// [v1.0.4新增] 总页数
		totalPage: { type: Number, default: 1}
	}
}
```

### 表格名称
1. 可单独配置是否显示表格名称列
2. 右侧菜单可单独控制是否展示
3. 文字样式、对齐方式、背景颜色可配置  

**相关配置：（props：nameOpt）**   
以下全部配置项（默认配置在`config.js -> defaultNameOpt`）   
```javascript
	nameOpt:{
		// isShow Boolean | 是否显示表格标题
		isShow: true,
		// title String | 标题文字
		title: '',
		// needMenu Boolean | 是否需要右侧菜单按钮
		needMenu: false,
		// bg String | 表格标题背景颜色
		bg: '#2979ff',
		// color String | 表格标题文字颜色
		color: '#ffffff',
		// bold Boolean | 是否加粗
		bold: true,
		// align String | 对齐方式 left/center/right
		align: 'left',
		// fontSize Boolean | 文字大小
		fontSize: 28
	}
```

### 表头
1. 支持多级表头（收起全部、展开全部）
2. 支持配置表头高度、文字样式、对齐方式、背景颜色（统一配置）
3. 支持单独配置每一列宽度、是否筛选、字符串模板

**相关配置：（props：headerOpt）**    

以下表头部分统一配置（默认配置在`config.js -> defaultHeaderOpt`）  

```javascript
// 表头配置
export const defaultHeaderOpt = {
	// bg String | 表头背景颜色
	bg: '#f3f4f6',
	// color String | 表头字体颜色
	color: '#333333',
	// bold Boolean | 表头文字是否加粗
	bold: true,
	// align String | 表头文字对齐方式 left/center/right
	align: 'center',
	// fontSize Number | 表头文字字体大小
	fontSize: 24,
	// height Number | 表头单元格高度
	height: 64,
	// border: Boolean | 是否显示表头边框  | 默认 true [v1.3.3]新增
	border:true, 
	// borderColor: String | 表头边框颜色，| 默认 '#dbdbdb'  [v1.3.3]新增
	borderColor: '#dbdbdb'
}
```
**多级表头说明：**  
支持无限嵌套 无需额外配置，根据`columns `自动识别（判断依据children）；eg：  
`columns`数据结构：  
```javascript
let columns: = [
	{
		"title": "广州一区",
		"children": [
			{ "title": "销售", "dataIndex": "广州一区销售", sort: true, },
			{ "title": "计划销售", "dataIndex": "广州一区计划销售" },
			{ "title": "达成", "dataIndex": "广州一区达成", sort: true }
		]
	}
]
```

## 表格基础配置：（`props:tableOpt`） ##

以下全部配置项(默认配置在`config.js -> defaultTableOpt`)
```javascript
// 表格整体配置
export const tableOpt = {
	// textAlign String | 内容对齐方式 left center right
	textAlign: 'center',
	// itemHeight Number | 单个cell高度 [v1.0.4移除]：文字自动换行
	// itemHeight: 64, 
	
	// fontSize Number | 字体大小
	fontSize: 26,
	// color String | 字体颜色 
	// 优先级 : 相对columns[item] -> item.bodyColor 低
	color: "#333",
	// emptyText String | 空数据显示的文字内容
	emptyText: '暂无数据',
	// isShowSum Boolean | 是否显示底部统计 默认不显示
	isShowSum: false,
	// stickSide Boolean | 是否固定左侧侧首栏 默认固定
	stickSide: true,
	// sumPlace String | 合计行位置 top / bottom, 仅 isShowSum = true 生效
	sumPlace: 'bottom',
	// border: Boolean | 是否显示表格内容边框  | 默认 true  [v1.3.3]新增
	border:true, 
	// borderColor: String | 表格内容边框颜色，| 默认 '#dbdbdb' [v1.3.3]新增
	borderColor: '#dbdbdb'
}
```

**columns说明**
```javascript

columns = [
	{
		title:'xx', //表头文字 支持html模板 eg `<span style='color:red'>区域1</span>`
		dataIndex:'data1', //  对应tableData取值的键 eg： data1 表示拿 tableData里面 键为data1 的值显示
		sort: false, // 可选 默认false 是否排序列（true情况下会出现排序按钮）
		width: 200, // 可选 默认200 Number类型，单元格宽度，表格内容会自动对齐
		color: '#333', // 可选，表头文字颜色
		bodyColor: '#333',// 可选，表格内容行颜色 优先级 : 相对tableOpt -> color 高
		isImage:false, // 可选，默认false， 是否为图片
		height: 64, // 可选，图片高度，仅在 isImage: true 情况下对图片生效
		isLink: false, // 可选， 默认false，是否为链接
		customName: '', // 可选，别名配置，默认空字符串  增加别名配置 2022年3月29日 v1.0.2新增
		children: [{title: 'xx1',key:'xxx1'},...],
		autoColor: false, // 可选，是否自动处理颜色：数字类型 单元格内容 = 0 正常颜色，< 0 minusColor | 绿色， > 0 positiveColor | 红色 [v1.3.3]新增
		minusColor: 'green', // 可选 自动处理小于0 时的颜色，[v1.3.3]新增
		positiveColor: 'red', // 自动处理大于0 时的颜色 [v1.3.3]新增
		
	},
	...
]
```

**tableData 说明**

```javascript
tableData = [
	{
		key: '111',
		data1: 'xx1',
		data2: 'xx2',
		children: [
			{ key: '112', data1: 'xx12', data2: 'xx13' , children:
				[
					...
				]
			},
			...
		],
		...
	}
]
```

## 分页配置 ##   
版本 v1.0.3 新增   
**功能介绍**：  
简单的功能组件，不喜欢的可以忽略不管，不影响原有功能。  
> 本功能针对表格内部处理，不对外暴露事件；  
> 主要根据传递进去的数据进行分页处理，分页数量计算：树形结构数据只根据第一层计算。  
> 开启后底部会有一个简单的分页组件

**新增功能[v1.0.4新增]**
> 增加 props -> currentPage 参数：当前页码，传递数字类型时 内部不做分页处理，并会暴露分页相关事件： @onNextPage , @onPrevPage。   
> -- 不传递或者传递false 组件内部处理分页。  
> 增加 props -> totalPage 参数： 总页数，

---

**总结：两种用法**   
1. 内部处理：props -> currentPage 不传递或者传递 false。
	 1. 组件内部对 tableData 做分页处理。不对外暴露分页相关方法
2. 外部处理：props -> currentPage 传递数字类型，表示当前页
	 1. 同时需要传递 props -> totalPage 参数，表示总页数
	 2. 对外暴露 onPrevPage 、onNextPage 事件，返回当前页

---

**[v1.0.5]更新**
增加分页组件样式配置(config.js -> defaultPagerOpt 新增对应默认配置 ):  
1. `pagerOpt -> btnFontSize` 按钮文字大小  
2. `pagerOpt -> btnFontColor` 按钮文字颜色  
3. `pagerOpt -> btnFontBold` 按钮文字是否加粗
4. `pagerOpt -> btnCustomClass` 按钮自定义类
5. `pagerOpt -> numFontSize` 页码字体大小
6. `pagerOpt -> numFontColor` 页码字体颜色
7. `pagerOpt -> numFontBold` 页码字体是否加粗
---


配置项：以下全部配置项(默认配置在`config.js -> defaultPagerOpt`)  
```javascript
export const defaultPagerOpt = {
	// show Boolean | 是否启用分页功能 
	show: false,
	// pageSize Number | 每页条数
	pageSize: 10,
	// [v1.0.5]新增
	// 按钮文字大小
	btnFontSize: 26,
	// 按钮文字颜色
	btnFontColor: '#333',
	// 按钮文字是否加粗
	btnFontBold: false,
	// 按钮自定义类
	btnCustomClass:'',
	// 页码文字大小
	numFontSize: 26,
	// 页码文字颜色
	numFontColor: '#333',
	// 页码文字是否加粗
	numFontBold: false,
}

```


## event 事件 ##

`@onSort`  点击排序触发，返回 `{sortKey,sortType}`  
  
`@onClick`  点击表格行内容，返回 `row, col`

`@clickMenu`  点击表格右上角菜单按钮触发，返回 `void`

`@onNextPage` 外部处理分页情况下点击下一页触发，返回当前页码

`@onPrevPage`  外部处理分页情况下点击上一页触发，返回当前页码

