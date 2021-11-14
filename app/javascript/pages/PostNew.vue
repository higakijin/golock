<template>
  <div>
    <Navbar />
    <div class="grid grid-cols-11 gap-4">
      <div class="col-span-1"></div>
      <div class="col-span-9">
        <div id="app">
          <form @submit.prevent="createPost">
            <div class="flex items-center mb-1 justify-center">
              <div class="shadow-md mt-10 mb-6 px-3 pt-3 w-11/12">
                <input type="text" v-model="title" required placeholder="タイトルを入力してください！" class="w-full my-3 appearance-none bg-transparent text-gray-700 mr-3 pb-2 leading-tight focus:outline-none border-green-500 border-b-2">
              </div>
              <button class="m-3 mt-6 w-1/12 px-2 py-1 bg-green-500 text-white font-semibold rounded hover:bg-green-600">投稿</button>
            </div>
            <div class="mb-12">
              <mavon-editor :language="'ja'" v-model="body" required class="h-screen"></mavon-editor>
            </div>
          </form>
        </div>
        <div class="col-span-1"></div>
      </div>
    </div>
    
  </div>
</template>

<script>
import axios from 'axios'
import Navbar from '../components/Navbar.vue'

export default {
  components: { Navbar },
  data () {
    return {
      title: '',
      body: '',
      error: null
    }
  },
  methods: {
    async createPost() {
      this.error = null
      try {
        const res = await axios.post('http://localhost:3000/posts', {
          headers: {
            uid: window.localStorage.getItem('uid'),
            "access-token": window.localStorage.getItem('access-token'),
            client: window.localStorage.getItem('client')
          },

          title: this.title,
          body: this.body
        })
        if (!res) {
          new Error('投稿できませんでした')
        }
        if (!this.error) {
          this.$router.push({ name: 'Posts' })
        }
        this.error = null
        return res
      } catch (error) {
        this.error = '投稿できませんでした'
      }
    }
  }
  
}
</script>

<style>
</style>