<template>
  <div>
    <Navbar />
    <div class="grid grid-cols-11 gap-4">
      <div class="col-span-1"></div>
      <div class="col-span-9">
        <div id="app">
          <TagInput />
          <form @submit.prevent>
            <div class="flex items-center mb-1 justify-center">
              <div class="shadow-md mt-10 mb-6 px-3 pt-3 w-full">
                <input type="text" v-model="title" required placeholder="タイトルを入力してください！" class="w-full my-3 appearance-none bg-transparent text-gray-700 mr-3 pb-2 leading-tight focus:outline-none border-green-500 border-b-2">
              </div>
              <div class="flex mt-4">
                <button type="submit" class="ml-4 m-2 whitespace-nowrap px-2 py-1 text-green-500 border border-green-500 font-semibold rounded hover:bg-green-100" @click="createPostForPrivate">下書き保存</button>
                <button type="submit" class="m-2 whitespace-nowrap px-2 py-1 bg-green-500 text-white font-semibold rounded hover:bg-green-600" @click="createPostForPublic">投稿</button>
              </div>
            </div>
            <div class="mb-12">
              <mavon-editor :language="'ja'" :toolbars="mavonEditor.toolbars" v-model="body" required class="h-screen"></mavon-editor>
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
import TagInput from '../components/TagInput.vue'

export default {
  components: { Navbar, TagInput },
  data () {
    return {
      title: '',
      body: '',
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
    async createPostForPrivate() {
      this.error = null
      
      try {
        const res = await axios.post('http://localhost:3000/posts', {
          
          uid: window.localStorage.getItem('uid'),
          "access-token": window.localStorage.getItem('access-token'),
          client: window.localStorage.getItem('client'),
          post: {
            title: this.title,
            body: this.body,
          },
          
          published: false
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
    },

    async createPostForPublic() {
      this.error = null
      
      try {
        const res = await axios.post('http://localhost:3000/posts', {
          uid: window.localStorage.getItem('uid'),
          "access-token": window.localStorage.getItem('access-token'),
          client: window.localStorage.getItem('client'),
          post: {
            title: this.title,
            body: this.body,
          },
          published: true
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