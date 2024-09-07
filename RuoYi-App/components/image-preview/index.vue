<template>
  <scroll-view class="right" scroll-y>
    <view class="item">
      <image
          v-for="(item, index) in displayedImages"
          :key="item.id"
          @click="previewImg(index)"
          :src="getImageUrl(item.url)"
          :style="{ width: `${width}rpx`, height: `${height}rpx` }"/>
    </view>
  </scroll-view>
</template>

<script>
import {baseUrl} from "@/config";

export default {
  props: {
    value: {
      type: String,
      default: ''
    },
    showAllImages: {
      type: Boolean,
      default: false
    },
    width: {
      type: Number,
      default: 80
    },
    height: {
      type: Number,
      default: 70
    }
  },
  data() {
    return {
      imageArray: [],
      currentIndex: 0
    }
  },
  computed: {
    displayedImages() {
      //判断图片是否有数据
      if (this.imageArray.length === 0) {
        return [];
      }
      return this.showAllImages ? this.imageArray : [this.imageArray[0]]; // 仅显示第一张图片
    }
  },
  watch: {
    value: {
      handler(val) {
        if (val && val !== '') {
          this.imageArray = val.split(",").map((item, index) => ({
            url: item,
            id: index
          }));
        }
      },
      deep: true,
      immediate: true,
    }
  },
  methods: {
    getImageUrl(url) {
      if (!url.startsWith("http")) {
        url = baseUrl + url
      }
      return url
    },
    previewImg(index) {
      const urls = this.imageArray.map(item => { // 遍历每个 URL，检查是否需要添加前缀
        if (!item.url.startsWith("http")) {
          return baseUrl + item.url;
        }
        return item.url;
      });
      uni.previewImage({
        current: urls[index], // 当前显示的图片
        urls,
        success: () => {
          // 成功回调
        },
        fail: (err) => {
          console.error('Image preview failed:', err);
        }
      });
      this.currentIndex = index; // 更新当前索引
    }
  },
  mounted() {
    // 监听 uni.previewImage 的回调来处理图片切换
    uni.$on('previewImageChange', (currentIndex) => {
      this.currentIndex = currentIndex;
    });
  }
}
</script>

<style lang="scss">
.right {
  height: 100%;
  width: 100%;
  margin: 1rpx auto;
  overflow: hidden;
  text-align: center;

  .item {
    display: flex;
    flex-direction: column;
    align-items: center;

    image {
      border-radius: 5px;
    }
  }
}
</style>
