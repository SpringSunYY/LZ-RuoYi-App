import Vue from 'vue'
import App from './App'
import store from './store' // store
import plugins from './plugins' // plugins
import './permission' // permission
import ImagePreview from "./components/image-preview/index.vue"
import ImageUpload from "./components/image-upload/index.vue"
import FileUpload from "./components/file-upload/index.vue"
import DictTag from "@/components/dict-tag/index.vue";
import * as myUtils from "@/utils/myUtils.js";
Vue.use(plugins)

Vue.config.productionTip = false
Vue.prototype.$store = store
Vue.prototype.$myUtils = myUtils
Vue.component("ImageUpload", ImageUpload)
Vue.component("FileUpload", FileUpload)
Vue.component("ImagePreview", ImagePreview)
Vue.component("DictTag", DictTag)
App.mpType = 'app'

const app = new Vue({
    ...App
})

app.$mount()
