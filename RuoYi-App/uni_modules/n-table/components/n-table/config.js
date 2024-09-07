// 表格标题配置
export const defaultNameOpt = {
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
	fontSize: 14
}

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
	fontSize: 14,
	// height Number | 表头单元格高度
	height: 32,
	// border Boolean | 是否显示表头边框 [v1.3.3]新增
	border: true,
	// borderColor String | 表头边框颜色 [v1.3.3]新增
	borderColor:'#dbdbdb'
}

// 表格整体配置
export const defaultTableOpt = {
	// textAlign String | 内容对齐方式 left center right
	textAlign: 'center',
	// itemHeight Number | 单个cell高度
	// itemHeight: 64, // 移除 [2022年4月7日]
	
	// fontSize Number | 文字高度
	fontSize: 12,
	// color String | 字体颜色
	color: '#333',
	// emptyText String | 空数据显示的文字内容
	emptyText: '暂无数据',
	// isShowSum Boolean | 是否显示底部统计 默认不显示
	isShowSum: false,
	// stickSide Boolean | 是否固定左侧侧首栏 默认固定
	stickSide: true,
	// sumPlace String | 合计行位置 top / bottom, 仅 isShowSum = true 生效
	sumPlace: 'bottom',
	// borderLeft Boolean | 是否显示表格内容边框[竖边框] [v1.3.4]新增
	borderLeft:true,
	// borderBottom Boolean | 是否显示表格内容边框[横边框] [v1.3.4]新增
	borderBottom: true, 
	// borderColor | 表格内容边框颜色 [v1.3.3]新增
	borderColor: '#dbdbdb'
	// borderColor: 'red'
}


export const defaultPagerOpt = {
	// show Boolean | 是否启用分页功能
	show: false,
	// pageSize Number | 每页条数
	pageSize: 10,
	// 按钮文字大小
	btnFontSize: 12,
	// 按钮文字颜色
	btnFontColor: '#333',
	// 按钮文字是否加粗
	btnFontBold: false,
	// 按钮自定义类
	btnCustomClass:'',
	// 页码文字大小
	numFontSize: 12,
	// 页码文字颜色
	numFontColor: '#333',
	// 页码文字是否加粗
	numFontBold: false,
}