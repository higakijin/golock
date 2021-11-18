<template>
  <div>
    <Navbar />
    <div>
      <p>{{ post.name }}</p>
      <p>投稿日　{{ createdAt }} </p>
      <p>更新日　{{ updatedAt }}</p>
    </div>
    <div>
      <h1 class="text-4xl font-bold">{{ post.title }}</h1>
    </div>

    <div>
      <markdown-it-vue class="md-body" :content="content" />
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

</style>