<template>
  <section class="text-gray-600 body-font overflow-hidden">
    <div class="container px-5 py-12 mx-auto">
      <div class="-my-8 divide-y-2 divide-gray-100">
        <div v-for='post in posts' :key="post.id">
          <div class="py-8 flex flex-wrap md:flex-nowrap">
            <div class='w-full'>
              <div class="md:w-64 md:mb-0 mb-6 flex-shrink-0 flex flex-col">
                <span class="font-semibold title-font text-gray-700">{{ post.name }}</span>
                <span class="mt-1 text-gray-500 text-sm">{{ post.created_at | moment("YYYY年MM月DD日") }}に投稿</span>
              </div>
              <div class="md:flex-grow">
                <router-link :to='`/posts/${post.id}/edit`' class='w-full'>
                  <h2 class="text-2xl font-medium text-gray-900 title-font mb-2">
                    {{ post.title }}
                  </h2>
                </router-link>
                <div class="flex">
                  <div v-for="tag in post.tags" :key="tag.id" class="flex">
                    <router-link to="#">
                      {{ tag.name }}
                    </router-link>
                    <p v-if="tag.name !== post.tags.slice(-1)[0].name" class="mr-2">,</p>
                  </div>
                </div>
                <router-link :to='`/posts/${post.id}/edit`' class="text-green-500 inline-flex items-center mt-4 w-full">
                  Edit
                  <svg class="w-4 h-4 ml-2" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M5 12h14"></path>
                    <path d="M12 5l7 7-7 7"></path>
                  </svg>
                </router-link>
              </div>
            </div>
            <div class="flex items-center">
              <button @click="postForPublic(post.id, post.tags)" class="px-2 py-1 text-green-500 border border-green-500 font-semibold rounded hover:bg-green-100 whitespace-nowrap">公開する</button>
            </div>
          </div>
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
      date: this.$moment().format(),
    }
  },
  methods: {
    async getPosts () {
      try {
        const res = await axios.get('http://localhost:3000/api/posts', {})
        if (!res) {
          new Error('メッセージを取得できませんでした。')
        }
        this.posts = res.data.filter((v) => !v.published)
                              .filter((v) => v.email === window.localStorage.getItem('uid'))
                              .reverse()
      } catch (error) {
        // メッセージを取得できませんでした。
      }
    },
    async postForPublic(id, tags) {
      let tag_array = []
      for (let i=0; i<=tags.length-1; i++) {
        tag_array.push(tags[i].name)
      }
      try {
        const res = await axios.patch(`http://localhost:3000/posts/${id}`, {
          uid: window.localStorage.getItem('uid'),
          "access-token": window.localStorage.getItem('access-token'),
          client: window.localStorage.getItem('client'),
          tags: {
            name: tag_array
          },
          published: true
        })
        this.getPosts()
        return res
      } catch (error) {
        // 公開できませんでした
      }
    }
  },
  mounted () {
    this.getPosts()
  }
}
</script>