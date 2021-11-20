<template>
  <div>
    <Navbar />

    <div class="grid grid-cols-11 gap-4">
      <div class="col-span-1"></div>
      <div class="col-span-9">
        <div id="app">
          <form @submit.prevent>
            <div class="flex items-center mb-1 justify-center">
              <div class="shadow-md mt-10 mb-6 px-3 pt-3 w-full">
                <input type="text" v-model="post.title" required placeholder="タイトルを入力してください！" class="w-full my-3 appearance-none bg-transparent text-gray-700 mr-3 pb-2 leading-tight focus:outline-none border-green-500 border-b-2">
              </div>
              <div class="flex mt-4">
                <button type="submit" class="ml-4 m-2 whitespace-nowrap px-2 py-1 text-green-500 border border-green-500 font-semibold rounded hover:bg-green-100" @click="updatePostForPrivate">下書き保存</button>
                <button type="submit" class="m-2 whitespace-nowrap px-2 py-1 bg-green-500 text-white font-semibold rounded hover:bg-green-600" @click="updatePostForPublic">投稿</button>
              </div>
            </div>
            <div class="mb-12">
              <mavon-editor :language="'ja'" :toolbars="mavonEditor.toolbars" v-model="post.body" required class="h-screen"></mavon-editor>
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
      post: '',
      error: null,

      mavonEditor: {
        toolbars: {
          bold: true,
          italic: true,
          header: true,
          underline: true,
          strikethrough: true,
          mark: true,
          superscript: true,
          subscript: true,
          quote: true,
          ol: true,
          ul: true,
          link: true,
          imagelink: false,
          code: false,
          table: true,
          fullscreen: false,
          readmodel: false,
          htmlcode: false,
          help: true,
          /* 1.3.5 */
          undo: true,
          redo: true,
          trash: false,
          save: false,
          /* 1.4.2 */
          navigation: false,
          /* 2.1.8 */
          alignleft: false,
          aligncenter: false,
          alignright: false,
          /* 2.2.1 */
          subfield: true,
          preview: true
        }
      }
    }
  },

  methods: {
    async RetunPostData() {
      this.error = null

      try {
        const res = await axios.get(`http://localhost:3000/api/posts/${this.$route.params['id']}`)
        if (!res) {
          new Error('メッセージを取得できませんでした。')
        }
        this.post = res.data
      } catch(error) {

      }
    },

    async updatePostForPrivate() {
      try {
        const res = await axios.patch(`http://localhost:3000/posts/${this.$route.params['id']}`, {
          uid: window.localStorage.getItem('uid'),
          "access-token": window.localStorage.getItem('access-token'),
          client: window.localStorage.getItem('client'),
          post: {
            title: this.post.title,
            body: this.post.body,
          },
          published: false
        })
        if (!res) {
          new Error('更新できませんでした')
        }
        if (!this.error) {
          this.$router.push({ name: 'Posts' })
        }
        this.error = null
        return res
      } catch (error) {
        this.error = '更新できませんでした'
      }
    },

    async updatePostForPublic() {
      try {
        const res = await axios.patch(`http://localhost:3000/posts/${this.$route.params['id']}`, {
          uid: window.localStorage.getItem('uid'),
          "access-token": window.localStorage.getItem('access-token'),
          client: window.localStorage.getItem('client'),
          post: {
            title: this.post.title,
            body: this.post.body,
          },
          published: true
        })
        if (!res) {
          new Error('更新できませんでした')
        }
        if (!this.error) {
          this.$router.push({ name: 'Posts' })
        }
        this.error = null
        return res
      } catch (error) {
        this.error = '更新できませんでした'
      }
    }
  },

  created()　{
    this.RetunPostData()
  },

}
</script>

<style>

</style>