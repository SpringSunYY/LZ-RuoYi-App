<template>
  <el-card>
    <el-tabs :tab-position="tabPosition" style="margin-bottom: 30px;height: 500px">
      <el-tab-pane
        v-for="(column,index) in columns"
        :key="column.columnId"
        :label="column.columnName"
        :name="column.columnName"
      >
        <el-form :ref="'form' + index" :model="tableValues[index]" label-width="80px" size="mini"
                 style="width: 500px; margin: 0 auto;"
        >
          <el-form-item label="字段描述">
            {{ tableValues[index].columnComment }}
          </el-form-item> <el-form-item label="物理类型">
            {{ tableValues[index].columnType }}
          </el-form-item>
          <el-form-item label="Java类型">
            {{ tableValues[index].javaType }}
          </el-form-item>
          <el-form-item label="Java属性">
            {{ tableValues[index].javaField }}
          </el-form-item>
          <el-form-item label="生成数值">
            <el-input v-model="tableValues[index].genValue" placeholder="请输入生成数值" />
          </el-form-item>
        </el-form>
        {{ tableValues[index] }}
      </el-tab-pane>
    </el-tabs>
    <el-form label-width="100px">
      <el-form-item style="text-align: center;margin-left:-100px;margin-top:10px;">
        <el-button type="primary" @click="submitForm()">提交</el-button>
        <el-button @click="close()">返回</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>
import { getGenTable, updateGenTable } from '@/api/tool/gen'
import { optionselect as getDictOptionselect } from '@/api/system/dict/type'
import { listMenu as getMenuTreeselect } from '@/api/system/menu'
import basicInfoForm from './basicInfoForm'
import genInfoForm from './genInfoForm'
import Sortable from 'sortablejs'

export default {
  name: 'GenEdit',
  components: {
    basicInfoForm,
    genInfoForm
  },
  data() {
    return {
      tabPosition: 'top',
      tableValues: [],
      // 选中选项卡的 name
      activeName: 'columnInfo',
      // 表格的高度
      tableHeight: document.documentElement.scrollHeight - 245 + 'px',
      // 表信息
      tables: [],
      // 表列信息
      columns: [],
      // 字典信息
      dictOptions: [],
      // 菜单信息
      menus: [],
      // 表详细信息
      info: {}
    }
  },
  created() {
    const tableId = this.$route.params && this.$route.params.tableId
    if (tableId) {
      // 获取表详细信息
      getGenTable(tableId).then(res => {
        this.columns = res.data.rows
        console.log(this.columns)
        // 初始化 tableValues，使其长度与 columns 一致
        this.tableValues = this.columns.map((item) => ({
          columnComment: item.columnComment,
          columnType: item.columnType,
          javaType: item.javaType,
          javaField: item.javaField,
        }))
        this.info = res.data.info
        this.tables = res.data.tables
      })
      /** 查询字典下拉列表 */
      getDictOptionselect().then(response => {
        this.dictOptions = response.data
      })
      /** 查询菜单下拉列表 */
      getMenuTreeselect().then(response => {
        this.menus = this.handleTree(response.data, 'menuId')
      })
    }
  },
  methods: {
    /** 提交按钮 */
    submitForm() {
      console.log(this.tableValues)
    },
    getFormPromise(form) {
      return new Promise(resolve => {
        form.validate(res => {
          resolve(res)
        })
      })
    },
    /** 关闭按钮 */
    close() {
      const obj = { path: '/tool/gen', query: { t: Date.now(), pageNum: this.$route.query.pageNum } }
      this.$tab.closeOpenPage(obj)
    }
  }
}
</script>
