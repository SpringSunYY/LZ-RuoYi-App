## 1.3.5（2022-06-09）
1. del: 移除 tableOpt.border 属性，
2. add: 新增 tableOpt.borderLeft 属性 控制是否显示竖向边框
3. add: 新增 tableOpt.borderBottom 属性，控制是否显示横向边框
4. update: 调整了树形结构下展开/收起图标的颜色（之前有点不显眼）
5. fix: 部分小细节调整
## 1.3.4（2022-06-08）
修复一些小bug
## 1.3.3（2022-06-07）
1. update: iconfont.scss
	- 字体文件引用改成 https形式
	- 新增两个图表：上箭头、下箭头；用于排序图标
2. update：排序图标现在跟表头文字颜色保持一致：非选中状态 透明度50，选中状态不透明
3. add：tableOpt新增配置：tableOpt.border 、tableOpt.borderColor 用于控制表格内容的边框是否显示及边框颜色
4. add：headerOpt新增配置：headerOpt.border 、 headerOpt.borderColor 用户控制表头的边框是否显示及边框颜色
5. add: columns 新增配置： columns[item].autoColor 、columns[item].minusColor、columns[item].positiveColor
  - columns[item].autoColor 开启后自动根据数值显示对应颜色，非数字类型或者0 取columns[item].borderColor 颜色，小于0 取 minusColor | 绿色。大于0取 positiveColor | 红色。
**以上新增可查看例子【模式示例】**
## 1.3.2（2022-05-30）
1. fix: 修复树形结构下三层以上结构，收起子级无法正确工作的bug。
2. 模式调整：
> columns[item].columnFmt = currency 时 现在会拼接单位(columnNumberCount)，在后缀(suffix)的前面
> columns[item].columnUnit = '万' | '亿' 的时候会自动将数据除以对应的比例
## 1.3.1（2022-05-27）
表格名称右侧的菜单按钮改了。
修复一些小bug
## 1.3.0（2022-05-24）
1. add: 新增 columns[item].columnFmt 格式化
> 可选值：  
> `default`: 默认模式，不对数据处理   
> `number`: 数值模式，此时 `columnNumberCount` 、 `useThousandth` 、 `columnUnit` 生效   
> `percentage`: 百分比模式（源数据是百分比数值），对数据进行 * 100 并拼接 %，此时 `columnNumberCount` 生效  
> `currency`: 货币模式，此时`columnNumberCount` 、`useThousandth` 、`prefix`、`suffix`生效
> `scientific`: 科学计算法模式，将数据处理成科学计算法显示 eg: 1.2e2
2. add: 新增 columns[item].columnUnit 单位(等于'无'时忽略此参数) `columnFmt == number`时生效
3. add: 新增 columns[item].useThousandth 是否使用千分位 `columnFmt == number || columnFmt== currency`时生效
4. add: 新增 columns[item].columnNumberCount 小数位 `columnFmt == number || columnFmt== percentage || columnFmt== currency`时生效
5. add: 新增 columns[item].prefix 前缀`columnFmt == currency`时生效
6. add: 新增 columns[item].suffix 后缀`columnFmt == currency`时生效
7. fix: 修复多级表头列数过少无法占满的问题。
8. update: columns[item].formatNum 默认值调整为`false`(原来默认是true)，此参数优先级高于上述的 5种模式
## 1.2.6（2022-05-07）
1. fix: 修复columns 第一项设置textAlign无效的问题：树形表格首列固定左对齐，其他可以自行设置 columns  -> textAlign；
## 1.2.5（2022-05-06）
1. add: 示例发布微信小程序
## 1.2.4（2022-04-27）
1. add: 增加高度占满示例，请更新示例项目查看(pages/index/fullPage.vue)
## 1.2.3（2022-04-26）
1. update: template 标签改成 block (微信小程序平台会将template编译成block)
## 1.2.2（2022-04-26）
1. fix: 修复部分警告提示，包括绑定key的警告提示
## 1.2.1（2022-04-26）
1. fix: 修复 Duplicate attribute 报错（原因是多写了一个 class 属性）
2. fix: 修复分组表格一些小问题   
**分别在 vue2-小程序、vue2-H5、vue3-小程序、vue3-h5 模式下运行，测试通过**
## 1.2.0（2022-04-25）
1. fix: 当表格列数总宽度不能铺满时候，最后一列会自动占满剩余空间
2. fix: 修复表头部分会有几px的空隙。
3. update: 表格边框采用细边框方案，提升整体颜值
4. add: 新增分组表格功能，示例已更新（示例2-第三个 **分组-没有[总计行]功能(不可用)** ）
5. add: columns[item].valueEnum : 值映射对象，示例： （示例2-第四个 **字段映射** ）
## 1.1.1（2022-04-19）
1. update: 单位改成 px，包括文字大小FontSize/ width/ height/ （横屏下 rpx 会有缺陷）
2. add: columns[item].hidden : 是否显示该列，默认false
3. add: props.defaultOpen : 树形结构下是否默认展开全部 默认false
## 1.1.0（2022-04-15）
1. add: columns[item].textAlign : 对应列内容文字对齐方式，优先级比 tableOpt.textAlign 高  例子看第二个
2. add: columns[item].titleTextAlign : 对应列表头文字对齐方式，优先级比 headerOpt.align 高 例子看第二个
## 1.0.9（2022-04-15）
1. fix: 移除 `v-bind` 语法
## 1.0.8（2022-04-14）
内部分页处理：改变tableData 重置 当前页与总页数
## 1.0.7（2022-04-14）
修复 tableData = [] 时候一直显示loading状态：  
tableData 为 Boolean类型时,显示 loading，空数组时候显示 无数据提示
## 1.0.6（2022-04-10）
设置不自动格式化数字：columns[i].formatNum = false ，默认true。   
原有功能，文档写漏了配置，文档已更新！！！
1. fix: 修复长数字类型换行失效
## 1.0.5（2022-04-08）

1. fix: 修复内部分页上一页失效 *[2022年4月8日]*  
2. fix: 修复报错 `Right-hand side of 'instanceof' is not an object`。组件部分`props`格式写错了 *[2022年4月8日]*  
3. add: 增加分页组件样式配置(config.js -> defaultPagerOpt 新增对应默认配置 ): *[2022年4月8日]*  
	 1. `pagerOpt -> btnFontSize` 按钮文字大小  
	 2. `pagerOpt -> btnFontColor` 按钮文字颜色  
	 3. `pagerOpt -> btnFontBold` 按钮文字是否加粗
	 4. `pagerOpt -> btnCustomClass` 按钮自定义类
	 5. `pagerOpt -> numFontSize` 页码字体大小
	 6. `pagerOpt -> numFontColor` 页码字体颜色
	 7. `pagerOpt -> numFontBold` 页码字体是否加粗
5. other: **感谢@gzakay的反馈**

> 示例、文档已同步更新
## 1.0.4（2022-04-07）
1. remove:  tableOpt -> itemHeight 配置,表格内部单元格高度自动撑开（文字超出自动换行）[2022年4月7日]
2. change：首列非树形结构对齐方式与 tableOpt -> textAlign 对齐，树形结构固定作对齐 [2022年4月7日]
3. add: 分页对外开放（可在外部处理），具体影响： [2022年4月7日]
	 1. props -> currentPage 当前页  参数类型：Boolean | Number；Boolean类型表示内部处理分页，Number类型表示外部处理，内部不做处理
	 2. props -> totalPage 总页数  
	 3. event  @onNextPage(currentPage) -> 下一页方法 返回当前页码
	 4. event  @onPrevPage(currentPage) -> 上一页方法 返回当前页码
4. change: 调整Loading样式，Loading过程中（tableData = false时会触发loading状态）无法点击其他 [2022年4月7日]
5. fix: 修复树形结构折叠无法折叠三层子集以下的bug [2022年4月7日]
6. other： **感谢@gzakay提的建议**

> 文档相关已更新
## 1.0.3（2022-04-01）
1. fix: 修复 headerOpt -> color 不生效 [2022年4月1日]
2. 新增分页功能，详细请看文档相关配置 [2022年4月1日]

## 1.0.2（2022-04-01）
1. add: 新增 columns 配置： customName , 别名；如果 customName 存在 则优先显示，否则显示 title
2. fix: 修复表格名称居中显示实际没有居中的问题
3. fix: 修复事件冒泡处理点击无反应的问题：click.native.stop --> click.stop(感谢 463***@qq.com 指出)

## 1.0.1 (2022-03-25)
1. fix: 修复tableHeight 高度计算不正确问题，现在这个高度会包括表格名称高度   
2. add: 新增 `props -> autoSort : Boolean default: true;` 组件内自动响应排序，默认true 详细请看文档
3. update: 移除数据错误提示

## 1.0.0（2022-03-22）
版本发布