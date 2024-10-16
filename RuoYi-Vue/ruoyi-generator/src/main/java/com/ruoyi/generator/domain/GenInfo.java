package com.ruoyi.generator.domain;

import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * @Project: RuoYi-Vue
 * @Package: com.ruoyi.generator.domain
 * @Author: YY
 * @CreateTime: 2024-10-16  23:05
 * @Description: GenInfo
 * 生成数据信息
 * @Version: 1.0
 */
public class GenInfo {
    private String tableName;
    private Long genNumbers;
    private List<Column> tableColumnValues;

    private static class Column {
        private String columnName;
        private String columnComment;
        private String columnType;
        private boolean pk;
        private String javaType;
        private String javaField;
        private boolean required;
        private int isSole;

        public String getColumnName() {
            return columnName;
        }

        public void setColumnName(String columnName) {
            this.columnName = columnName;
        }

        public String getColumnComment() {
            return columnComment;
        }

        public void setColumnComment(String columnComment) {
            this.columnComment = columnComment;
        }

        public String getColumnType() {
            return columnType;
        }

        public void setColumnType(String columnType) {
            this.columnType = columnType;
        }

        public boolean isPk() {
            return pk;
        }

        public void setPk(boolean pk) {
            this.pk = pk;
        }

        public String getJavaType() {
            return javaType;
        }

        public void setJavaType(String javaType) {
            this.javaType = javaType;
        }

        public String getJavaField() {
            return javaField;
        }

        public void setJavaField(String javaField) {
            this.javaField = javaField;
        }

        public boolean isRequired() {
            return required;
        }

        public void setRequired(boolean required) {
            this.required = required;
        }

        public int getIsSole() {
            return isSole;
        }

        public void setIsSole(int isSole) {
            this.isSole = isSole;
        }

        @Override
        public String toString() {
            return "\nColumn{" +
                    "columnName='" + columnName + '\'' +
                    ", columnComment='" + columnComment + '\'' +
                    ", columnType='" + columnType + '\'' +
                    ", pk=" + pk +
                    ", javaType='" + javaType + '\'' +
                    ", javaField='" + javaField + '\'' +
                    ", required=" + required +
                    ", isSole=" + isSole +
                    '}';
        }
    }

    @NotBlank(message = "表名不能为空！！！")
    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public Long getGenNumbers() {
        return genNumbers;
    }

    public void setGenNumbers(Long genNumbers) {
        this.genNumbers = genNumbers;
    }

    public List<Column> getTableColumnValues() {
        return tableColumnValues;
    }

    public void setTableColumnValues(List<Column> tableColumnValues) {
        this.tableColumnValues = tableColumnValues;
    }

    @Override
    public String toString() {
        return "GenInfo{" +
                "tableName='" + tableName + '\'' +
                ", genNumbers=" + genNumbers +
                ", tableColumnValues=" + tableColumnValues +
                '}';
    }
}
