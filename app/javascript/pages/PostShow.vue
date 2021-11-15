<template>
  <div>
    <Navbar />
    <div>
      <p>{{ post.name }}</p>
      <p>投稿日{{ post.created_at | moment("YYYY年MM月DD日") }}　　更新日{{ post.updated_at | moment("YYYY年MM月DD日") }}</p>
    </div>
    <div>
      <h1 class="text-4xl font-bold">{{ post.title }}</h1>
    </div>
    <mavon-editor
      v-model="body"
      language="ja"
      :subfield="false"
      defaultOpen="preview"
      :toolbars="markdownOption"
      :boxShadow='false'

    />
  </div>
</template>

<script>
import Navbar from '../components/Navbar.vue'
import axios from 'axios'

export default {

  components: { Navbar },
  
  data ()  {
    return {
      date: this.$moment().format(),
      post: '',
      body: '',
      markdownOption: {
        preview: false
      }
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
        this.body = this.post.body
      } catch (error) {
        // エラーメッセージ
      }
    },
  },
  
  mounted() {
    this.getPostShow()
  }
}
</script>

<style>

</style>