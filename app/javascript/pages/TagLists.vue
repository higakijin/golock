<template>
  <div>
    <Navbar />
    <div class="grid grid-cols-7 gap-4">
      <div class="col-span-2">
        <h2># {{ $route.params.tag_name }}</h2>
        <p>このタグをフォローする</p>

      </div>
      <div class="col-span-4">
        <PostLists @getPosts='this.getPosts' @resetPosts='this.resetPosts' @re_tag_name='this.re_tag_name' :posts="this.posts"/>
      </div>
      <div class="col-span-1">

      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import Navbar from '../components/Navbar.vue'
import PostLists from '../components/PostLists.vue'

export default {
  components: { Navbar, PostLists },
  data() {
    return {
      posts: [],
      tag_name: this.$route.params.tag_name
    }
  },
  methods: {
    async getPosts () {
      try {
        const res = await axios.get('http://localhost:3000/api/posts', {})
        if (!res) {
          new Error('メッセージを取得できませんでした。')
        }
        res.data.filter(v => {
          v.tags.forEach(key => {
            if(key.name.indexOf(this.tag_name)!== -1) {
              if (key.name === this.tag_name) {
                this.posts.push(v)
              }
            }
          })
        })
      } catch (error) {
      }
    },
    resetPosts() {
      this.posts = []
    },
    re_tag_name(new_path) {
      this.tag_name = new_path
    }
  }
}
</script>