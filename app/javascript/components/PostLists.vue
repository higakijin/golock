<template>
  <section class="text-gray-600 body-font overflow-hidden">
    <div class="container px-5 py-12 mx-auto">
      <div class="-my-8 divide-y-2 divide-gray-100">
        <div v-for='(post, postIndex) in sortedPostsByUpdated' :key='`post-${postIndex}`'>
          <div class="py-8 flex flex-wrap md:flex-nowrap">
            <div class='w-full'>
              <div class="md:w-64 md:mb-0 mb-6 flex-shrink-0 flex flex-col">
                <span class="font-semibold title-font text-gray-700">{{ post.name }}</span>
                <span class="mt-1 text-gray-500 text-sm">{{ post.created_at | moment("YYYY年MM月DD日") }}に投稿</span>
              </div>
              <div class="md:flex-grow">
                <router-link :to='`/posts/${post.id}`' class='w-full'>
                  <h2 class="text-2xl font-medium text-gray-900 title-font mb-2">
                    {{ post.title }}
                  </h2>
                </router-link>
                <div class="flex">
                  <div class="px-1" v-if="post.tags.length > 0">
                    <font-awesome-icon icon="tags" />
                  </div>
                  <div v-for="tag in post.tags" :key="tag.id" class="flex">
                    <router-link :to='`/posts/tags/${tag.name}`' class="hover:underline">
                      {{ tag.name }}
                    </router-link>
                    <p v-if="tag.name !== post.tags.slice(-1)[0].name" class="mr-2">,</p>
                  </div>
                </div>
                <router-link :to='`/posts/${post.id}`' class="text-green-500 inline-flex items-center mt-4 w-full">
                  Learn More
                  <svg class="w-4 h-4 ml-2" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M5 12h14"></path>
                    <path d="M12 5l7 7-7 7"></path>
                  </svg>
                </router-link>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  props: ["posts"],
  data() {
    return {
      date: this.$moment().format(),     
    }
  },
  mounted() {
    this.$emit('getPosts')
  },

  computed: {
    sortedPostsByUpdated() {
      return this.posts.sort((a, b) => {
        return (a.updated_at < b.updated_at) ? 1 : (a.updated_at > b.updated_at) ? -1 : 0;
      })
    },
  },

  watch: {
    $route(to, from) {
      this.$emit('resetPosts')
      this.$emit('re_tag_name', this.$route.params.tag_name)
      this.$emit('getPosts')
    }
  }
}
</script>