<template>
  <uni-file-picker :limit="limit"
                   v-model="filesValue"
                   mode="grid"
                   file-mediatype="all"
                   :file-extname="fileExtname"
                   :disabled="disabled"
                   @select="select"
                   :title="title"
                   @progress="progress"
                   @success="success"
                   @fail="fail"
                   :del-icon="!disabled">
  </uni-file-picker>
</template>

<script>
import {
  baseUrl
} from "@/config";
import {
  getToken
} from "@/utils/auth";

export default {
  props: {
    value: {
      default: "",
    },
    // 上传数
    limit: {
      default: "1",
    },
    //
    fileExtname: {
      default: ['docx', 'doc', 'pdf']
    },
    disabled: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      filesValue: [],
      title: '',
      headers: {
        Authorization: "Bearer " + getToken(),
      },
    };
  },
  watch: {
    value: {
      handler(val, oval) {
        if (val && val != oval) {
          this.filesValue = [];
          let arr = val.split(",");

          if (arr) {
            arr.forEach((item) => {
              let name = item.split("/").pop(); // 文件名
              let extname = name.split(".")[1]; // 后缀名
              this.filesValue.push({
                url: item,
                name,
                extname,
              });
            });
          }
        }
      },
      deep: true, //是否深度监听
      immediate: true, //是否监听初始
    },
    filesValue: {
      handler(val, oval) {
        if (val.length > 0) {
          let arr = [];
          val.forEach((item) => {
            arr.push(item.url);
          });
          let str = arr.join(",");
          if (this.limit === 1) {
            str = arr[0]
          }
          this.$emit("input", str);
        } else {
          this.$emit("input", "");
        }
      },
      deep: true, //是否深度监听
      immediate: true, //是否监听初始
    },
  },
  created() {
    this.setTitle()
  },
  methods: {
    updata(filePath) {
      const that = this;
      // const accessToken = uni.getStorageSync("App-Token") || null; // 获取token
      uni.uploadFile({
        url: baseUrl + "/common/upload", // 上传路径
        filePath: filePath,
        name: "file",
        header: that.headers,
        // HTTP 请求中其他额外的 form data
        formData: {},
        success(res) {
          // 上传成功，返回值是后端返回的值，组件以json格式获取到值，所以需要转换成对象
          let response = JSON.parse(res.data);
          console.log(response)
          // console.log("=======上传文件完成======>", response);
          if (response.url != undefined) {
            // 判断上传成功与否，也可以通过状态码进行判断
            // 把后端返回的上传后的文件路径组装成字符串，传递给父组件
            let str;
            if (that.value) {
              str = that.value + "," + response.url;
            } else {
              str = response.url;
            }
            that.$emit("input", str); // 同步给父组件
            uni.showToast({
              title: "上传文件成功",
              duration: 2000,
            });
          } else {
            uni.showToast({
              title: "上传文件失败,请重试!",
              icon: "none",
              duration: 2000,
            });
          }
        },
        fail(err) {
          uni.showToast({
            title: "上传文件失败,请重试!",
            icon: "none",
            duration: 2000,
          });
        },
      });
    },
    // 获取上传状态
    select(e) {
      console.log("选择文件：", e);
      e.tempFilePaths.forEach((item) => {
        this.updata(item);
      });
    },
    // 获取上传进度
    progress(e) {
      console.log("上传进度：", e);
    },

    // 上传成功
    success(e) {
      console.log("上传成功");
    },

    // 上传失败
    fail(e) {
      console.log("上传失败：", e);
    },
    setTitle() {
      this.title = "最多选择" + this.limit + "个文件，类型为：" + this.fileExtname.join(",")
    }
  },
};
</script>

<style lang="scss" scoped></style>
