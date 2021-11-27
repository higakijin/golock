<template>
  <div>
    <Navbar />
    
    <div class="grid grid-cols-7 gap-4 mt-12 mb-28">
      <div class="col-span-1"></div>
      <div class="col-span-4">
        <div class="text-gray-500 flex gap-x-7">
          <p>{{ createdAt }}に投稿</p>
          <p>{{ updatedAt }}に更新</p>
          <p>Posted by {{ post.name }}</p>
        </div>
        <div class="flex items-center my-3">
          <h1 class="text-4xl font-bold">{{ post.title }}</h1>
          <div class="ml-auto flex">
            <router-link v-show='isCurrentUser' :to='`/posts/${post.id}/edit`' class="whitespace-nowrap px-2 py-1 text-green-500 border border-green-500 font-semibold rounded hover:bg-green-100">編集</router-link>
            <div v-show='isCurrentUser' @click='deletePost' class="whitespace-nowrap px-2 py-1 ml-3 text-red-500 border border-red-500 font-semibold rounded hover:bg-red-100 cursor-pointer">削除</div>
          </div>
        </div>
        <div class="mb-5 flex text-gray-600">
          <div class="px-1" v-if="tag_count">
            <font-awesome-icon icon="tags" />
          </div>
          <div v-for="tag in post.tags" :key="tag.id" class="flex">
            <router-link :to='`/posts/tags/${tag.name}`' class="hover:underline">
              {{ tag.name }}
            </router-link>
            <p v-if="tag.name !== post.tags.slice(-1)[0].name" class="mr-2">,</p>
          </div>
        </div>
        <markdown-it-vue class="md-body" :content="content" />
      </div>
      <div class="col-span-2"></div>
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

      content: '',
      isCurrentUser: '',

      tag_count: false
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

        if (this.post.tags.length > 0) {
          this.tag_count = true
        }
      } catch (error) {
        // エラーメッセージ
      }
      if (this.post.uid === window.localStorage.getItem('uid')) {
        this.isCurrentUser = true
      } else {
        this.isCurrentUser = false
      }
      if (!this.isCurrentUser && !this.post.published) {
        this.$router.push({ name: 'Posts' })
      }
    },

    async deletePost () {
      try {
        const params = {
          uid: window.localStorage.getItem('uid'),
          "access-token": window.localStorage.getItem('access-token'),
          client: window.localStorage.getItem('client'),
        }
        const res = await axios.delete(`http://localhost:3000/posts/${this.$route.params['id']}`, {
          data: params,
          id: this.post.id
        }) 
        if (!res) {
          new Error('メッセージを取得できませんでした。')
        }
        if (!this.error) {
          this.$router.push({ name: 'Posts' })
        }
        this.error = null

        return res
      } catch (error) {
        console.log(error);
      }
    },
  },
  
  mounted() {
    this.getPostShow()
  },

}
</script>

<style>
.md-body h1 {
  font-size: 24px;
  margin-top: 60px;
}

.md-body pre {
  font-size: 12px
}
</style>