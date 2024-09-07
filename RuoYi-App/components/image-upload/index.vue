<template>
  <uni-file-picker v-if="!disabled" :auto-upload="true" :limit="limit" v-model="imageValue" fileMediatype="image"
                   mode="grid" @select="select" @progress="progress" @success="success" @fail="fail"
                   :title="'最多选择' + limit + '张图片'"/>
  <view v-else class="preview">
    <img v-for="(item, i) in imageValue" @click="previewImage(item.url)" class="viewImg" :src="getImageUrl(item.url)"
         :key="i"/>
  </view>
</template>

<script>
import {
  getToken
} from "@/utils/auth";
import {
  baseUrl
} from "@/config"; // 默认路径
export default {
  props: {
    value: {
      default: "",
    },
    // 上传张数
    limit: {
      default: "9",
    },
    disabled: {
      default: false,
      // default: true,
    },
  },
  data() {
    return {
      imageValue: [],
      headers: {
        Authorization: "Bearer " + getToken(),
      },
    };
  },
  watch: {
    value: {
      handler(val, oval) {
        // 监听父组件的值，时并实时赋值给imageValue
        if (val && val != oval) {
          this.imageValue = [];
          let arr = val.split(",");
          if (arr) {
            arr.forEach((item) => {
              if (!item.startsWith("http")) {
                item = baseUrl + item
              }
              this.imageValue.push({
                url: item,
              });
            });
          }
        }
      },
      deep: true, //是否深度监听
      immediate: true, //是否监听初始值
    },
    imageValue: {
      handler(val, oval) {
        // 监听imageValue的值(删除图片，上传图片)，并同步给父组件
        if (val.length >= 0) {
          let arr = [];
          val.forEach((item) => {
            arr.push(item.url);
          });
          const str = arr.join(",");
          this.$emit("input", str); // 同步给父组件
        }
      },
      deep: true, //是否深度监听
      immediate: true, //是否监听初始值
    },
  },
  methods: {
    updata(filePath) {
      const that = this;
      // console.log('Bearer ' + getToken())
      // const accessToken = uni.getStorageSync("Authorization") || null; //获取token
      uni.uploadFile({
        url: baseUrl + "/common/upload", // 上传路径
        filePath: filePath,
        name: 'file',
        header: that.headers,
        success(res) {
          console.log(res)
          // 上传成功，返回值是后端返回的值，组件以json格式获取到值，所以需要转换成对象
          let response = JSON.parse(res.data);
          // console.log("=======上传图片完成======>", response);
          if (response.fileName != undefined) {
            // 判断上传成功与否，也可以通过状态码进行判断
            // 把后端返回的上传后的图片路径组装成字符串，传递给父组件
            let str;
            if (that.value) {
              str = that.value + "," + response.url;
            } else {
              str = response.url;
            }
            that.$emit("input", str); // 同步给父组件
            uni.showToast({
              title: "上传图片成功",
              duration: 2000,
            });
          } else {
            uni.showToast({
              title: "上传图片失败,请重试!",
              icon: "none",
              duration: 2000,
            });
          }
        },
        fail(err) {
          console.log("=======上传图片失败======>", err);
          uni.showToast({
            title: "上传图片失败,请重试!",
            icon: "none",
            duration: 2000,
          });
        },
      });
    },
    // 获取上传状态
    select(e) {
      // console.log("选择文件：", e);
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

    previewImage(url) {
      try {
        // 预览图片
        uni.previewImage({
          urls: [url],
        });
      } catch (e) {
        console.log('111')
      }
    },
  },
};
</script>

<style lang="scss" scoped>
.preview {
  display: grid;
  grid-template-columns: 240rpx 240rpx 240rpx; // 三列
  /* 设置间距 */
  grid-gap: 20rpx;

  .viewImg {
    width: 240rpx;
    height: 240rpx;
  }
}
</style>
