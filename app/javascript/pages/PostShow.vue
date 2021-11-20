<template>
  <div>
    <Navbar />
    
    <div class="grid grid-cols-7 gap-4 mt-12 mb-28">
      <div class="col-span-1"></div>
      <div class="col-span-5">
        <div>
          <p>投稿日{{ createdAt }}　|　更新日{{ updatedAt }}　　Posted by {{ post.name }}</p>
        </div>
        <div class="flex">
          <h1 class="text-4xl font-bold my-5">{{ post.title }}</h1>
          <router-link :to='`/posts/${post.id}/edit`' class="m-6 ml-auto whitespace-nowrap px-2 py-1 text-green-500 border border-green-500 font-semibold rounded hover:bg-green-100">編集</router-link>
        </div>
        <markdown-it-vue class="md-body" :content="content" />
      </div>
      <div class="col-span-1"></div>
    </div>
  </div>
</template>

<script>
import Navbar from '../components/Navbar.vue'
import axios from 'axios'

import MarkdownItVue from 'markdown-it-vue'
import 'markdown-it-vue/dist/markdown-it-vue.css'

import { compareAsc, format } from 'date-fns'


export default {

  components: { Navbar, MarkdownItVue },
  
  data ()  {
    return {
      date: this.$moment().format(),
      post: '',
      markdownOption: {
        preview: false
      },
      createdAt: '',
      updatedAt: '',

      content: ''
    }
  },
  methods: {
    async getPostShow () {
      try {
        const res = await axios.get(`http://localhost:3000/api/posts/${this.$route.params['id']}`)
        if (!res) {
          new Error('メッセージを取得できませんでした。')
        }
        this.post = res.data
        this.createdAt = format(new Date(this.post.created_at), 'yyyy年MM月dd日')
        this.updatedAt = format(new Date(this.post.updated_at), 'yyyy年MM月dd日')
        this.content = res.data.body
      } catch (error) {
        // エラーメッセージ
      }
    },
  },
  
  mounted() {
    this.getPostShow()
  },

}
</script>

<style>
/* マークダウンの記述はこちらの記入 */
.markdown-body h1 {
  font-size: 25px;
  margin-top: 60px;
}

.markdown-body pre {
  font-size: 12px
}
</style>