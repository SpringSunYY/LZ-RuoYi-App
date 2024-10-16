<template>
  <el-card>
    <el-tabs :tab-position="tabPosition" type="border-card" style="margin-bottom: 30px;min-height: 600px">
      <el-tab-pane
        v-for="(column,index) in columns"
        :key="column.columnId"
        :name="column.columnName"
      >
        <span slot="label"><svg-icon v-if="column.required" icon-class="star" style="color: red"/> {{
            column.columnName
          }}</span>
        <el-form :ref="'form' + index" :model="tableValues[index]" label-width="80px" size="mini"
                 style="width: 500px; margin: 0 auto;"
        >
          <el-form-item label="字段名称">
            <span>{{ tableValues[index].columnName }}</span>
          </el-form-item>
          <el-form-item label="字段描述">
            <span>{{ tableValues[index].columnComment }}</span>
          </el-form-item>
          <el-form-item label="物理类型">
            <span> {{ tableValues[index].columnType }}</span>
          </el-form-item>
          <el-form-item label="Java类型">
            <span>{{ tableValues[index].javaType }}</span>
          </el-form-item>
          <el-form-item label="Java属性">
            <span>{{ tableValues[index].javaField }}</span>
          </el-form-item>
          <el-form-item label="是否唯一">
            <el-radio-group v-model="tableValues[index].isSole">
              <el-radio :label="0">否</el-radio>
              <el-radio :label="1">是</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item v-if="column.htmlType==='textarea'"
                        label="生成数值"
                        :rules="[
                      { required: column.required, message: `${column.columnComment} 不能为空`, trigger: 'blur' }
                    ]"
          >
            <el-input v-model="tableValues[index].value" type="textarea" placeholder="请输入生成数值"/>
          </el-form-item>
          <el-form-item v-if="column.htmlType==='datetime'"
                        label="生成数值"
                        :rules="[
                      { required: column.required, message: `${column.columnComment} 不能为空`, trigger: 'blur' }
                    ]"
          >
            <el-date-picker clearable
                            v-model="tableValues[index].value"
                            type="date"
                            value-format="yyyy-MM-dd"
                            placeholder="请选择日期"
            >
            </el-date-picker>
          </el-form-item>
          <el-form-item v-if="column.htmlType==='imageUpload'"
                        label="生成数值"
                        :rules="[
                      { required: column.required, message: `${column.columnComment} 不能为空`, trigger: 'blur' }
                    ]"
          >
            <image-upload v-model="tableValues[index].value"/>
          </el-form-item>
          <el-form-item v-if="column.htmlType==='fileUpload'"
                        label="生成数值"
                        :rules="[
                      { required: column.required, message: `${column.columnComment} 不能为空`, trigger: 'blur' }
                    ]"
          >
            <file-upload v-model="tableValues[index].value"/>
          </el-form-item>
          <el-form-item v-if="column.htmlType==='editor'"
                        label="生成数值"
                        :rules="[
                      { required: column.required, message: `${column.columnComment} 不能为空`, trigger: 'blur' }
                    ]"
          >
            <editor v-model="tableValues[index].value"/>
          </el-form-item>
          <el-form-item
            label="生成数值"
            :rules="[
                      { required: column.required, message: `${column.columnComment} 不能为空`, trigger: 'blur' }
                    ]"
          >
            <el-input v-model="tableValues[index].value" placeholder="请输入生成数值"/>
          </el-form-item>
        </el-form>
        {{ tableValues[index] }}
      </el-tab-pane>
    </el-tabs>
    <el-form label-width="1000px" :inline="true" model="formInline" class="demo-form-inline">
      <el-form-item label="生成总数">
        <el-input v-model="genInfo.genNumbers" placeholder="请输入生成总数"></el-input>
      </el-form-item>
      <el-form-item >
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
      //生成信息
      genInfo: {},
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
        // 初始化 tableValues，使其长度与 columns 一致
        this.tableValues = this.columns.map((item) => ({
          columnName: item.columnName,
          columnComment: item.columnComment,
          columnType: item.columnType,
          javaType: item.javaType,
          javaField: item.javaField,
          required: item.required,
          isSole: 0
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
      //校验是否有必须需要值但是为空的
      for (const index in this.columns) {
        const column = this.columns[index]
        const value = this.tableValues[index]?.value // 获取对应的值
        if (column.required && (!value || value.trim() === '')) {
          // 如果 required 为 true 且值不存在或为空
          this.$message.error(`${column.columnComment}不能为空`)
          return // 直接返回
        }
      }
      console.log(this.tableValues)
    }
    ,
    getFormPromise(form) {
      return new Promise(resolve => {
        form.validate(res => {
          resolve(res)
        })
      })
    }
    ,
    /** 关闭按钮 */
    close() {
      const obj = { path: '/tool/gen', query: { t: Date.now(), pageNum: this.$route.query.pageNum } }
      this.$tab.closeOpenPage(obj)
    }
  }
}
</script>
