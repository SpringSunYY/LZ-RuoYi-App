<template>
  <view class="body-wrapper" ref="bodyWrapper" id="bodyWrapper">
    <block v-for="(row, iIndex) in dataList" :key="iIndex">
      <!-- 分组 -->
      <block v-if="isGroup">
        <view class="n-table-container-row group-row" :key="iIndex" v-if="row.children">
          <view class="group-head">

            <view class="n-table-container-col head-row group-col n-border border-bottom"
                  style="text-align: left;"
                  :style="{
								width: '99.9vw',
								backgroundColor: '#fff',
								borderRight: 0,
								color: borderColor
								}">
              <view class="group-title" :style="{color: color }">
                {{ row.GroupKey }}
              </view>
              <view
                  class="iconfont"
                  style="font-size: 12px;color: #666;"
                  @click="openGroup(row)"
                  :class="row.open ? 'icon-arrow-up' : 'icon-arrow-down'"></view>
            </view>

            <block v-if="row.open">
              <view v-if="!row.children.length" class="no-data">
                暂无数据
              </view>
              <block v-else>
                <view v-for=" (child, childIdx) in row.children" :key="childIdx"
                      class="group-open-wrap">
                  <view v-for="(col, jIndex) in dataIndexs"
                        :class="['n-table-container-col',
										{ 'head-row': jIndex == 0,
										'n-table-stick-side': stickSide && jIndex == 0 ,
										'text-left': getTextAlign(col) === 'left' && !isTree,
										'text-center': getTextAlign(col) === 'center' && !isTree,
										'text-right': getTextAlign(col) === 'right' && !isTree ,
										'n-border': borderBottom || borderLeft,
										'border-right': borderLeft,
										'border-bottom': borderBottom,
										}]"
                        :style="{
													width: getItemStyle(col).width,
													paddingLeft: jIndex == 0 ? ( isTree ? (row.level + 1) : row.level  )*8 + 'px' : '8px',
													color:borderColor
										}"
                        :key="jIndex">
                    <view
                        :class="['n-table-col-text', {'text-left': getTextAlign(col) === 'left' , 'text-center': getTextAlign(col) === 'center' , 'text-right': getTextAlign(col) === 'right'}]"
                        :style="{
												color: getTxColor(col, row, col.bodyColor || color),
												fontSize: fontSize + 'px' ,
												fontWeight: getTxBold(row)
												}">

                      <view class="tx-content" v-if="!col.isLink && !col.isImage"
                            v-html="getRowContent(child, col,jIndex == (dataIndexs.length-1))">
                      </view>


                      <!-- 图片 -->
                      <view v-if="col.isImage" class="n-table-col-img">
                        <image
                            v-if="child[col[colKey]]"
                            @click="preViewImg(child[col[colKey]])"
                            :src="getImageUrl(child[col[colKey]])" mode="heightFix"
                            :style="{width: col.width ? col.width + 'px' : '30px', height:col.height ? col.height + 'px' : '30px'}">
                        </image>
                        <view class="" v-else>
                          -
                        </view>
                      </view>

                      <view v-if="col.isTag">
                        <view>tag</view>
                      </view>

                      <!-- 最后一列(操作列) -->
                      <view v-if="(jIndex == (dataIndexs.length-1)) && row[col[colKey]]">
                        <!-- <uni-icons v-if="showButton.includes('edit')" :type="iconsButStyle[showButton.indexOf('edit')]" color="blue" size="24" @click="editButton(row, col)"></uni-icons>
                        <uni-icons v-if="showButton.includes('add')" :type="iconsButStyle[showButton.indexOf('add')]" color="blue" size="24" @click="addButton(row, col)"></uni-icons>
                        <uni-icons v-if="showButton.includes('delete')" :type="iconsButStyle[showButton.indexOf('delete')]" color="blue" size="24" @click="deleteButton(row, col)"></uni-icons>
                        <uni-icons v-if="showButton.includes('custom')" :type="iconsButStyle[showButton.indexOf('custom')]" color="blue" size="24" @click="customButton(row, col)"></uni-icons>
                        <uni-icons v-if="showButton.includes('custom2')" :type="iconsButStyle[showButton.indexOf('custom2')]" color="blue" size="24" @click="customButton2(row, col)"></uni-icons> -->

                        <uni-icons
                            v-if="showButton.includes('edit') && checkPermi([hasPermiArr[showButton.indexOf('edit')]])"
                            :type="iconsButStyle[showButton.indexOf('edit')]" color="blue" size="24"
                            @click="editButton(row, col)"></uni-icons>
                        <uni-icons
                            v-if="showButton.includes('add') && checkPermi([hasPermiArr[showButton.indexOf('add')]])"
                            :type="iconsButStyle[showButton.indexOf('add')]" color="blue" size="24"
                            @click="addButton(row, col)"></uni-icons>
                        <uni-icons
                            v-if="showButton.includes('delete') && checkPermi([hasPermiArr[showButton.indexOf('delete')]])"
                            :type="iconsButStyle[showButton.indexOf('delete')]" color="blue" size="24"
                            @click="deleteButton(row, col)"></uni-icons>
                        <uni-icons
                            v-if="showButton.includes('custom') && checkPermi([hasPermiArr[showButton.indexOf('custom')]])"
                            :type="iconsButStyle[showButton.indexOf('custom')]" color="blue" size="24"
                            @click="customButton(row, col)"></uni-icons>
                        <uni-icons
                            v-if="showButton.includes('custom2') && checkPermi([hasPermiArr[showButton.indexOf('custom2')]])"
                            :type="iconsButStyle[showButton.indexOf('custom2')]" color="blue" size="24"
                            @click="customButton2(row, col)"></uni-icons>
                      </view>

                      <!-- 链接 -->
                      <block v-if="col.isLink">
                        <!-- #ifdef H5 -->
                        <router-link v-if="setUrl(child, col).indexOf('http') != 0"
                                     :to="setUrl(child, col)"
                                     v-html="getRowContent(child, col,jIndex == (dataIndexs.length-1))">
                        </router-link>
                        <a v-else :href="setUrl(child, col)"
                           v-html="getRowContent(child, col,jIndex == (dataIndexs.length-1))"></a>
                        <!-- #endif -->

                        <!-- #ifndef H5 -->
                        <navigator :url="setUrl(child, col)"
                                   v-html="getRowContent(child, col,jIndex == (dataIndexs.length-1))"></navigator>
                        <!-- #endif -->
                      </block>

                    </view>
                  </view>
                </view>
              </block>
            </block>
          </view>
        </view>
      </block>

      <!-- 其他 -->
      <block v-if="!isGroup">
        <view class="n-table-container-row"
              :class="{'sum-row': row.isSumRow}"
              :style="{
										backgroundColor: row.isSumRow && sumBg ? sumBg : '',
									}"
              v-if="row.level === 0 || checkOpen(row.parentIds[row.parentIds.length - 1])"
              :key="iIndex">
          <block v-for="(col, jIndex) in dataIndexs" :key="jIndex">
            <view
                v-if="!col.hidden"
                :class="['n-table-container-col',
							{ 'head-row': jIndex == 0,
							'n-table-stick-side': stickSide && jIndex == 0 ,
							'text-left': getTextAlign(col) === 'left' && !isTree,
							'text-center': getTextAlign(col) === 'center' && !isTree,
							'text-right': getTextAlign(col) === 'right' && !isTree ,
							'n-border': borderBottom || borderLeft,
							'border-right': borderLeft,
							'border-bottom': borderBottom,
							}]"
                :style="{
								width: getItemStyle(col).width,
								paddingLeft: jIndex == 0 ? ( isTree ? (row.level + 1) : row.level  )*8 + 'px' : '8px',
								color: borderColor,
								backgroundColor: row.isSumRow && sumBg ? sumBg : '',
							 }"
                :key="jIndex"
                @click.stop="itemClick(row, col)">

              <!-- 展开 -->
              <view
                  class="open-child"
                  v-if="jIndex === 0"
                  @click.stop="toggleOpen(row)">
                <view
                    v-if="row.hasChildren"
                    class="iconfont"
                    style="font-size: 12px;color: #666;"
                    :class="checkOpen(row[idKey]) ? 'icon-arrow-up' : 'icon-arrow-down'"></view>
                <view class="" v-else style="padding-left:20rpx;"></view>
              </view>

              <view
                  :class="['n-table-col-text', {'text-left': getTextAlign(col) === 'left', 'text-center': getTextAlign(col) === 'center', 'text-right': getTextAlign(col) === 'right'}]"
                  :style="{
								 color: getTxColor(col,row, col.bodyColor || color),
								 fontSize: fontSize + 'px',
								 fontWeight: getTxBold(row),
								 }">
                <view class="tx-content" v-if="!col.isLink && !col.isImage && !col.isTag"
                      v-html="getRowContent(row, col,jIndex == (dataIndexs.length-1))">
                </view>

                <!-- 图片 -->
                <view v-if="col.isImage" class="n-table-col-img">
                  <image
                      v-if="row[col[colKey]]"
                      @click="preViewImg(row[col[colKey]])"
                      :src="getImageUrl(row[col[colKey]])" mode="heightFix"
                      :style="{width: col.width ? col.width + 'px' : '32px', height:col.height ? col.height + 'px' : '32px'}">
                  </image>
                  <view class="" v-else>
                    -
                  </view>
                </view>
                <view v-if="col.isTag">
                  <dict-tag :options="col.optionsList" :value="row[col[colKey]]"/>
                </view>
                <!-- 最后一列(操作列) -->
                <view v-if="(jIndex == (dataIndexs.length-1)) && row[col[colKey]]">
                  <uni-icons v-if="showButton.includes('edit') && checkPermi([hasPermiArr[showButton.indexOf('edit')]])"
                             :type="iconsButStyle[showButton.indexOf('edit')]" color="blue" size="24"
                             @click="editButton(row, col)"></uni-icons>
                  <uni-icons v-if="showButton.includes('add') && checkPermi([hasPermiArr[showButton.indexOf('add')]])"
                             :type="iconsButStyle[showButton.indexOf('add')]" color="blue" size="24"
                             @click="addButton(row, col)"></uni-icons>
                  <uni-icons
                      v-if="showButton.includes('delete') && checkPermi([hasPermiArr[showButton.indexOf('delete')]])"
                      :type="iconsButStyle[showButton.indexOf('delete')]" color="blue" size="24"
                      @click="deleteButton(row, col)"></uni-icons>
                  <uni-icons
                      v-if="showButton.includes('custom') && checkPermi([hasPermiArr[showButton.indexOf('custom')]])"
                      :type="iconsButStyle[showButton.indexOf('custom')]" color="blue" size="24"
                      @click="customButton(row, col)"></uni-icons>
                  <uni-icons
                      v-if="showButton.includes('custom2') && checkPermi([hasPermiArr[showButton.indexOf('custom2')]])"
                      :type="iconsButStyle[showButton.indexOf('custom2')]" color="blue" size="24"
                      @click="customButton2(row, col)"></uni-icons>
                </view>
                <!-- 链接 -->
                <block v-if="col.isLink">
                  <!-- #ifdef H5 -->
                  <router-link v-if="setUrl(row, col).indexOf('http') != 0"
                               :to="setUrl(row, col)"
                               v-html="getRowContent(row, col,jIndex == (dataIndexs.length-1))"></router-link>
                  <a v-else :href="setUrl(row, col)"
                     v-html="getRowContent(row, col,jIndex == (dataIndexs.length-1))"></a>
                  <!-- #endif -->

                  <!-- #ifndef H5 -->
                  <navigator :url="setUrl(row, col)"
                             v-html="getRowContent(row, col,jIndex == (dataIndexs.length-1))"></navigator>
                  <!-- #endif -->
                </block>

              </view>
            </view>
          </block>

        </view>
      </block>

    </block>

  </view>
</template>

<script>
import {checkPermi} from "@/utils/permission";
import {baseUrl} from "@/config";
// 权限工具类
export default {
  name: 'tableBody',
  props: {
    // 单元格高度
    colKey: {type: String, default: 'key'},
    idKey: {type: String, default: 'id'},
    dataIndexs: {type: Array, default: () => []},
    stickSide: {type: Boolean, default: false},
    textAlign: {type: String, default: 'center'},
    fontSize: {type: [Number, String], default: 12},
    color: {type: String, default: '#333'},
    bold: {type: Boolean, default: false},
    // 是否展开全部
    isOpenAll: {type: Boolean, default: false},
    isTree: {type: Boolean, default: false},
    dataList: {
      type: [Array, Boolean],
      default: () => []
    },
    empty: {
      type: Boolean,
      default: false
    },
    defaultOpen: {type: Boolean, default: false},
    isGroup: {type: Boolean, default: false},
    borderLeft: {type: Boolean, default: true},
    borderBottom: {type: Boolean, default: true},
    borderColor: {type: String, default: '#dbdbdb'},
    sumBg: {type: String, default: '#fff'}, // 汇总行背景颜色
    sumBold: {type: Boolean, default: true}, // 汇总行字体加粗
    sumTxColor: {type: String, default: '#333'},
    //拥有的按钮权限数组，需与showButton顺序一致
    hasPermiArr: {
      type: Array,
      default: ['system:role:edit', 'system:role:remove', 'system:role:authUser', 'system:role:dataScope']
    },
    //需要展示的按钮的样式,需与showButton顺序一致
    iconsButStyle: {type: Array, default: ['plus-filled', 'compose', 'trash-filled']},
    //需要展示的按钮
    showButton: {type: Array, default: ['add', 'edit', 'delete']}
  },
  data() {
    return {
      openList: [],
      canOpenObj: {}, // 保存所有能展开的列Id
      needToogleTree: true
    }
  },
  watch: {
    isOpenAll: {
      handler(val) {
        if (!this.needToogleTree) return
        if (!this.dataList) return
        if (val) {
          this.openAll()
        } else {
          this.closeAll()
        }
      },
      immediate: true
    },
    dataList: {
      handler(val) {
        this.updataCanOpen(val)
        this.defaultOpen && this.initDefaultOpen(val)
      },
      deep: true,
      immidate: true
    },
  },
  methods: {
    checkPermi,
    getTxBold(row) {
      if (row.isSumRow) {
        return this.sumBold ? 'bold' : 'normal'
      } else {
        return this.bold ? 'bold' : 'normal'
      }
    },
    getTxColor(col, row, defaultColor) {
      if (row.isSumRow) {
        return this.sumTxColor || defaultColor
      }
      if (col.autoColor) {
        const {minusColor, positiveColor} = col
        let val = row[col[this.colKey]]
        if (typeof val === 'number') {
          if (val === 0) return defaultColor
          return val > 0 ? positiveColor || 'red' : minusColor || 'green'
        }
      }
      return defaultColor
    },
    // 默认打开全部
    initDefaultOpen(list) {
      this.openList = list.reduce((ls, item) => {
        return item.hasChildren ? ls.concat(item[this.idKey]) : ls
      }, [])
    },

    getTextAlign(col) {
      return col.textAlign || this.textAlign
    },

    // 计算宽度
    getItemStyle(item) {
      let {width, children} = item
      width = width || 100
      if (typeof width != "number") {
        width = 100
      }
      let height = '32px'
      let lineHeight = '32px'
      if (children && children.length) {
        width = children.length * width
      }
      return {width: width + 'px', height, lineHeight}
    },

    // 更新可展开id对象
    updataCanOpen(list) {
      if (!list || !list.length) {
        this.canOpenObj = {}
        return
      }
      this.canOpenObj = Object.assign({},
          list.reduce((obj, item) => {
            // 保存子列id
            if (item.hasChildren) obj[item[this.idKey]] = item.children.reduce((ls, item) => ls.concat(
                item[this.idKey]), [])
            return obj
          }, {}))
    },

    // 点击行展开、收起时触发
    // 判断是否全部已展开/收起
    checkIsAll() {
      this.needToogleTree = false
      if (this.isOpenAll) {
        // 判断是否已全部关闭 -- 通知 title-column 改变按钮状态
        if (this.openList.length === 0) this.$emit('toggleTree', true)
      } else {
        // 判断是否已全部打开 -- 通知 title-column 改变按钮状态
        let hasOpenAll = true
        let idx
        Object.keys(this.canOpenObj).forEach(key => {
          idx = this.openList.findIndex(item => item === key)
          if (idx <= -1) hasOpenAll = false
        })
        if (hasOpenAll) this.$emit('toggleTree', false)
      }
      this.$nextTick(() => {
        this.needToogleTree = true
      })
    },

    // 打开所有
    openAll() {
      this.openList = this.dataList.reduce((ls, item) => {
        return item.hasChildren ? ls.concat(item[this.idKey]) : ls
      }, [])
    },

    // 关闭所有
    closeAll() {
      this.openList = []
    },

    // 点击 展开/收起
    toggleOpen(row) {
      if (!this.checkOpen(row[this.idKey])) {
        // 展开
        this.openList.push(row[this.idKey]);
        console.log(this.openList)
      } else {
        // 收起
        this.closeItem(row)
      }
      // 判断更新是否已经全部关闭/打开了
      this.checkIsAll()
    },

    closeItem(row) {
      let closeIds = this.getChildIds([], row)
      let idx = -1
      while (closeIds.length) {
        let delItem = closeIds.pop()
        idx = this.openList.findIndex(it => it === delItem)
        if (idx >= 0) this.openList.splice(idx, 1)
      }
    },

    // 获取所有子项 ID
    getChildIds(result, item) {
      if (item.children) {
        result.push(String(item[this.idKey]))
        item.children.forEach(it => {
          this.getChildIds(result, it)
        })
      }
      return result
    },

    // 格式化数字
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

    /**
     * 表格值处理函数 获取当前显示文本
     * @param {Object} row
     * @param {Object} col
     * @param {Boolean} ifFinalCol 是否最后一列
     */
    getRowContent(row, col, ifFinalCol) {
      if (ifFinalCol) return ''//最后一列返回空字符串。为操作列
      let {
        valueEnum,
        formatNum = false,
        format,
        render,
        columnUnit,
        columnFmt = 'default',
        useThousandth = false,
        prefix,
        suffix,
        columnNumberCount
      } = col
      // columnFmt（数值类型）: default:默认 number：数值 percentage：百分比 scientific：科学型
      // columnUnit（单位） ： 直接拼接到后面
      // useThousandth（是否使用千分位） Boolean
      // columnNumberCount（小数位数）

      let celValue = row[col[this.colKey]]
      let tempHTML = ''
      let result = '' // 保存结果

      // 空值处理
      if ([null, '', (void 0)].includes(celValue) && !ifFinalCol) return '-'

      // 字段映射
      if (valueEnum) {
        tempHTML = this.getEnumValue(celValue || '-', valueEnum)
        // 存在映射值则直接返回
        if (tempHTML) return tempHTML.toString()
      }

      // 自动处理数字
      if (formatNum) {
        tempHTML = isNaN(celValue - 0) || !formatNum ? celValue : this.numTransform(celValue - 0)
        return tempHTML.toString()
      }

      result = this.fmtValue({
        value: celValue,
        columnFmt,
        useThousandth,
        columnNumberCount,
        columnUnit,
        prefix,
        suffix
      })

      return result.toString()
    },

    // 处理显示数据
    fmtValue({value, columnFmt, useThousandth, columnNumberCount, columnUnit, prefix, suffix}) {
      if (!columnFmt) return value
      if (columnUnit === '无') columnUnit = ''
      // 默认
      const numValue = Number(value)
      const isNumber = !isNaN(numValue)
      let tempResult = value
      if (columnFmt === 'default') {
        // 默认直接返回 值
        return value
      }
      if (columnFmt === 'number') {
        // 数字类型
        if (!isNumber) return value
        if (columnUnit) tempResult = this.transformUnit(numValue, columnUnit)
        if (this.isValidData(columnNumberCount)) tempResult = tempResult.toFixed(Number(columnNumberCount))
        if (useThousandth) tempResult = this.setThousandth(tempResult)
        return tempResult + (columnUnit ? columnUnit : '')

      } else if (columnFmt === 'percentage') {
        // 百分比：数值乘以 100 并加上 %
        if (!isNumber) return value
        tempResult = numValue * 100
        if (this.isValidData(columnNumberCount)) tempResult = tempResult.toFixed(Number(columnNumberCount))
        return tempResult + '%'

      } else if (columnFmt === 'scientific') {
        // 科学计算型:
        if (!isNumber) return value
        let p = Math.floor(Math.log(numValue) / Math.LN10);
        let n = numValue * Math.pow(10, -p);
        return n + 'e' + p
      } else if (columnFmt === 'currency') {
        // 货币：
        // 不是数字类型,直接拼接 前缀后缀返回
        if (!isNumber) {
          // 前缀 后缀
          return `${prefix || ''}${value}${suffix || ''}`
        }
        if (columnUnit) tempResult = this.transformUnit(numValue, columnUnit)
        // 小数位
        if (isNumber && this.isValidData(columnNumberCount)) {
          tempResult = tempResult.toFixed(Number(columnNumberCount))
        }
        // 是否使用千分位
        if (isNumber && useThousandth) {
          tempResult = this.setThousandth(tempResult)
        }
        return `${prefix || ''}${tempResult}${columnUnit || ''}${suffix || ''}`
      }
    },

    // 根据单位处理数据
    transformUnit(val, unit) {
      let fmtRes = Number(val)
      switch (unit) {
        case '万':
          fmtRes = val / 10000
          break;
        case '亿':
          fmtRes = val / 100000000
          break;
        case 'K':
          break;
        case 'M':
          break;
        case 'G':
          break
        default:
          break;
      }
      return fmtRes
    },

    // 千分位
    setThousandth(val) {
      const num = String(val)
      const reg = /\d{1,3}(?=(\d{3})+$)/g
      const res = num.replace(/^(-?)(\d+)((\.\d+)?)$/, function (match, s1, s2, s3) {
        return s1 + s2.replace(reg, '$&,') + s3
      })
      return res
    },

    // 判断字符串值是否有效
    isValidData(val) {
      return val && val !== null && val !== undefined && val !== ''
    },


    /**
     * 判断图片路径 如果用逗号分割，则直接获取图片的第一个路径
     * @param imageUrl
     * @returns {*}
     */
    getImageUrl(imageUrl) {
      var urls = imageUrl.split(",");
      if (Array.isArray(urls) && urls.length > 0) {
        let firstUrl = urls[0];
        // 判断如果不是以 "http" 开头，则添加前缀
        if (!firstUrl.startsWith("http")) {
          firstUrl = baseUrl + firstUrl;
        }
        return firstUrl; // 返回处理后的第一张图片地址
      }
      return imageUrl; // 如果不是数组，直接返回传递的数据
    },
    /**
     * 图片预览
     * @param {Object} src
     */
    preViewImg(src) {
      var urls = src.split(",");
      // 遍历每个 URL，检查是否需要添加前缀
      urls = urls.map(url => {
        if (!url.startsWith("http")) {
          return baseUrl + url;
        }
        return url;
      });
      uni.previewImage({
        current: urls[0], // 当前显示的图片
        urls,
        success: () => {
          // 成功回调
        },
        fail: (err) => {
          console.error('Image preview failed:', err);
        }
      });
    },

    /**
     * 判断是否展开子列
     * @param {Object} id
     */
    checkOpen(id) {
      return ~this.openList.findIndex(o => o === id);
    },

    /**
     * 行点击 this.$emit('onClick', row, col)
     * @param {Object} row
     * @param {Object} col
     */
    itemClick(row, col) {
      this.$emit('onClick', row, col)
    },

    setUrl(row, col) {
      if (!col.isLink) return
      let urlParam = {}
      let {isLink: {url, params = []}} = col
      params.forEach(item => {
        if (~item.indexOf('|')) {
          let temp = item.split('|')
          urlParam[temp[0]] = row[temp[1]]
        } else {
          urlParam[item] = row[item]
        }
      })
      url = this.setUrlParams(url, urlParam)
      return url
    },

    /**
     * @description 拼接 url 与 参数
     * @param {Object} url
     * @param {Object} params
     * @return {String} 拼接后的链接
     */
    setUrlParams(url, params) {
      let tempUrl = url
      Object.keys(params).forEach(item => {
        tempUrl += `&${item}=${params[item]}`
      })
      tempUrl = tempUrl.replace(/\&/, '?')
      return tempUrl
    },


    openGroup(row) {
      row.open = !row.open
    },

    /**
     * 获取映射的值
     * @param {String | Number} value 值 | a
     * @param {Object} valueEnum 映射对象 | {a: 'A的值', b: 'B的值'}
     * @return { Ayn }: valueEnum[value] | 'A的值'
     */
    getEnumValue(value, valueEnum) {
      let isValid = Object.prototype.toString.call(valueEnum) === '[object Object]'
      if (!isValid) {
        console.warn(`warn: valueEnum = ${JSON.stringify(valueEnum)}; columns[item].valueEnum 接受一个对象`)
        return undefined
      }
      let _value = String(value)
      return valueEnum[_value]
    },
    //操作列，编辑按钮
    editButton(row, col) {
      this.$emit('editButton', row, col)
    },
    //操作列，新增按钮
    addButton(row, col) {
      this.$emit('addButton', row, col)
    },
    //操作列，删除按钮
    deleteButton(row, col) {
      this.$emit('deleteButton', row, col)
    },
    //操作列，自定义按钮
    customButton(row, col) {
      this.$emit('customButton', row, col)
    },
    //操作列，自定义按钮
    customButton2(row, col) {
      this.$emit('customButton2', row, col)
    }
  }
}
</script>

<style lang="scss" scoped>
@import "./iconfont.scss";
@import "./common.scss";

.body-wrapper {
  width: 100%;
}

.n-table-container-row {
  display: flex;
  width: fit-content;
  white-space: nowrap;
  box-sizing: border-box;
  z-index: 0;
  box-sizing: border-box;
  width: 100%;
}

.n-table-container-col {
  // @include ellipsis();
  display: inline-flex;
  padding: 16rpx 10rpx;
  // height: 64rpx;
  align-items: center;
  // line-height: 64rpx;
  box-sizing: border-box;
}

.n-table-container-col:last-of-type {
  flex: 1;
}

.n-table-stick-side {
  position: sticky;
  left: 0;
  z-index: 2;
  background: #f7f9ff;
  box-sizing: border-box;
}

.head-row .n-table-col-text {
  width: auto;
  flex: 1;
}

.n-table-col-text {
  display: flex;
  width: 100%;
  flex: 1;
  justify-content: flex-start;
  align-content: center;
}

.text-left {
  justify-content: flex-start;
}

.text-center {
  justify-content: center;
}

.text-right {
  justify-content: flex-end;
}

.n-table-col-img {
  display: flex;
  justify-content: center;
}

.open-child {
  position: relative;

  &::after {
    z-index: 2;
    position: absolute;
    content: '';
    width: 100%;
    height: 100%;
    left: 0;
    top: 0;
    padding-right: 30rpx;
  }
}

.tx-content {
  max-width: 100%;
  white-space: pre-wrap;
  overflow: hidden;
  word-break: break-all;
}

.group-col {
  display: flex;
  justify-content: space-between;
  padding: 12px;

  position: sticky;
  left: 0;
  background: #f4f4f5;
  box-sizing: border-box;
  z-index: 2;

  .iconfont {
    padding: 5rpx 20rpx;
  }
}

.group-open-wrap {
  display: flex;
  justify-content: flex-start;
}

.group-row {
  position: sticky;
  left: 0;
  background: #f9f8f8;
  box-sizing: border-box;

  .group-head {
    position: sticky;
    left: 0;
  }
}

.no-data {
  text-align: center;
  padding: 15px;
  color: #999;
}
</style>
