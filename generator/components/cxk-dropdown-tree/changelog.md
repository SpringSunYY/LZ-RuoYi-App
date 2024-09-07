# 1.4.1

## 版本调整

建议更新，但需要注意，异步数据的时候，后台需返回 leaf 字段来判断是否末项数据

1. **调整数据项格式，新增 `leaf` 字段，来判断是否为末节点**
2. **调整数据项格式，新增 `sort` 字段，来排序节点位置**
3. **注意：异步加载数据，当为末项的时候，需要服务端数据返回 `leaf` 字段**
4. 新增 `alwaysFirstLoad` ，即异步数据总会在第一次展开节点时，拉取一次后台数据，来比对是否一致
5. 拆分 `field` 属性，**注意： 1.5.0 版本后将移除 `field` 属性**
6. 新增 `labelField` 同 `field.label`，指定节点对象中某个属性为**标签**字段，默认`label`
7. 新增 `valueField` 同 `field.key`，指定节点对象中某个属性为**值**字段，默认`value`
8. 新增 `childrenField` 同 `field.children`，指定节点对象中某个属性为**子树节点**字段，默认`children`
9. 新增 `disabledField` 同 `field.disabled`，指定节点对象中某个属性为**禁用**字段，默认`disabled`
10. 新增 `appendField` 同 `field.append`，指定节点对象中某个属性为**副标签**字段，默认`append`
11. 新增 `leafField` 同 `field.label`，指定节点对象中某个属性为**末级节点**字段，默认`leaf`
12. 新增 `sortField` 同 `field.label`，指定节点对象中某个属性为**排序**字段，默认`sort`
13. 新增 `isLeafFn` ，用来自定义控制数据项的末项
14. 更多的项目示例
15. 支持单选取消选中
16. 修复节点展开时可能存在的 bug
17. 修复节点选择可能存在的 bug
18. 调整为子节点默认继承父节点禁用属性
19. `setExpandedKeys` 添加参数一为 `all` 即可支持一键展开/收起全部节点
20. 其它更多优化

# 1.3.4

优化

1. 优化图标字体命名

# 1.3.3

版本同步于 Vue3 版，[查看 Vue3 版更新日志](https://ext.dcloud.net.cn/plugin?id=12384&update_log)

# 1.3.2

版本同步于 Vue3 版，[查看 Vue3 版更新日志](https://ext.dcloud.net.cn/plugin?id=12384&update_log)

# 1.3.1.1

修复

1. 修复 APP 兼容性引起的报错

# 1.3.1

## 建议更新

### 1.2.2~1.3.1 更新预览

1. 新增支持主题换色
2. 新增支持点击标签也能选中节点
3. 新增`field`字段 `append` 用于在标签后面显示小提示
4. 方法`setExpandedKeys`支持加载动态数据
5. 支持单选的`onlyRadioLeaf`为`true`时可点父节点展开/收起
6. 新增 `expandChecked`，控制选择时是否展开当前已选的所有下级节点
7. 新增 `checkedDisabled`，支持渲染禁用值
8. 新增 `packDisabledkey`，支持返回已选中的禁用的 key
9. 更多细节修复、优化请移步 Vue3 版的更新日志

后续版本仍不会实时同步 Vue3 版本，如急需新功能，请移步 Vue3 版

版本同步于 Vue3 版，[查看 Vue3 版更新日志](https://ext.dcloud.net.cn/plugin?id=12384&update_log)

# 1.2.2

## 建议更新，优化诸多问题

版本同步于 Vue3 版，[查看 Vue3 版更新日志](https://ext.dcloud.net.cn/plugin?id=12384&update_log)

# 1.2.1

版本同步于 Vue3 版，[查看 Vue3 版更新日志](https://ext.dcloud.net.cn/plugin?id=12384&update_log)

# 1.2.0.1

优化

1. 优化小程序兼容

# 1.2.0

版本同步于 Vue3 版，[查看 Vue3 版更新日志](https://ext.dcloud.net.cn/plugin?id=12384&update_log)

# 1.1.1.1

修复

1. 修复同步版本的错误写法引起的报错

# 1.1.1

版本同步于 Vue3 版，[查看 Vue3 版更新日志](https://ext.dcloud.net.cn/plugin?id=12384&update_log)

# 1.1.0

版本同步于 Vue3 版，[查看 Vue3 版更新日志](https://ext.dcloud.net.cn/plugin?id=12384&update_log)

# 1.0.6

新增

版本同步于 Vue3 版，[查看 Vue3 版更新日志](https://ext.dcloud.net.cn/plugin?id=12384&update_log)

# 1.0.5

版本同步于 Vue3 版，[查看 Vue3 版更新日志](https://ext.dcloud.net.cn/plugin?id=12384)，基于 Vue2 进行开发，支持单选、多选，全平台兼容。
