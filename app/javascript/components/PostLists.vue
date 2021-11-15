<template>
  <section class="text-gray-600 body-font overflow-hidden">
    <div class="container px-5 py-24 mx-auto">
      <div class="-my-8 divide-y-2 divide-gray-100">
        <div v-for='post in posts' :key="post.id">
          <router-link :to='`/posts/${post.id}`'>
            <div class="py-8 flex flex-wrap md:flex-nowrap">
              <div class="md:w-64 md:mb-0 mb-6 flex-shrink-0 flex flex-col">
                <span class="font-semibold title-font text-gray-700">{{ post.name }}</span>
                <span class="mt-1 text-gray-500 text-sm">{{ post.created_at | moment("YYYY年MM月DD日") }}に投稿</span>
              </div>
              <div class="md:flex-grow">
                <h2 class="text-2xl font-medium text-gray-900 title-font mb-2">{{ post.title }}</h2>
                <p class="leading-relaxed">Rails, Ruby, HTML, JQuery</p>
                <a class="text-green-500 inline-flex items-center mt-4">Learn More
                  <svg class="w-4 h-4 ml-2" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M5 12h14"></path>
                    <path d="M12 5l7 7-7 7"></path>
                  </svg>
                </a>
              </div>
            </div>
          </router-link>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      posts: [],
      date: this.$moment().format()
    }
  },
  methods: {
    async getPosts () {
      try {
        const res = await axios.get('http://localhost:3000/api/posts', {})
        if (!res) {
          new Error('メッセージを取得できませんでした。')
        }
        // this.posts = res.data.reverse() // 降順に設定
        this.posts = res.data.filter((v) => v.published).reverse()
      } catch (error) {
        // メッセージを取得できませんでした。
      }
    }
  },
  mounted () {
    this.getPosts()
  }

}
</script>