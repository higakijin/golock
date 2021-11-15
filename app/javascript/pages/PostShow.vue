<template>
  <div>
    <Navbar />
  </div>
</template>

<script>
import Navbar from '../components/Navbar.vue'
import axios from 'axios'

export default {
  components: { Navbar, VueMarkdownIt },
  
  data ()  {
    return {
      post: '',
      source: ''
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
        this.source = this.post.body
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