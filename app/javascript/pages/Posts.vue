<template>
  <div>
    <Navbar />
    <div class="grid grid-cols-7 gap-4">
      <div class="col-span-1">

      </div>
      <div class="col-span-4">
        <PostLists @getPosts='this.getPosts' :posts="this.posts" />
      </div>
      <div class="col-span-2">
        <TagRank />
      </div>
    </div>
    
  </div>
</template>

<script>
import Navbar from '../components/Navbar.vue'
import PostLists from '../components/PostLists.vue'
import TagRank from '../components/TagRank.vue'

import axios from 'axios'

export default {
  components: { Navbar, PostLists, TagRank },
  data () {
    return {
      posts: [],
    }
  },
  methods: {
    async getPosts () {
      try {
        const res = await axios.get('http://localhost:3000/api/posts', {})
        if (!res) {
          new Error('メッセージを取得できませんでした。')
        }
        this.posts = res.data.filter((v) => v.published).reverse()
      } catch (error) {
        // メッセージを取得できませんでした。
        
      }
    }
  },
  
}
</script>