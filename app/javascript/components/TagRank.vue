<template>
  <div class="mt-10">
    <h3 class="text-base font-medium text-center"><font-awesome-icon icon="crown" /> タグ・ランキング</h3>
    <table class="mx-auto mt-2 w-3/4">
      <tbody>
        <tr v-for='(tag, index) in sortedTagsByCount' :key='tag.id'>
          <th class="w-1/4 font-medium">{{ checkRank(tags[index-1], tag, index) }}位</th>
          <th nowrap class="w-1/2 font-medium" style="white-space: nowrap; text-overflow:ellipsis; overflow: hidden; max-width:1px;">
            <router-link :to='`/posts/tags/${tag.name}`' class="hover:underline">
              {{ tag.name }}
            </router-link>
          </th>
          <th class="w-1/4 font-medium">{{ tag.count }}件</th>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios'

let rank = 0

export default {
  data() {
    return {
      tags: [],
    }
  },
  methods: {
    async getTagData() {
      try {
        const res = await axios.get('http://localhost:3000/api/tags', {})
        if (!res) {
          new Error('メッセージを取得できませんでした。')
        }
        this.tags = res.data
      } catch (error) {

      }
    },
    checkRank(pre, current, index) {
      if (index === 0) {
        rank = index + 1
        return rank
      } else if (pre.count === current.count) {
        return rank
      } else {
        rank = index + 1
        return rank
      }
    },
  },
  mounted() {
    this.getTagData()
    
  },
  computed: {
    sortedTagsByCount() {
      return this.tags
        .sort((a, b) => {
          return (a.count < b.count) ? -1 : (a.count > b.count) ? 1 : 0;
        })
        .reverse()
        .filter(tag=> tag.count >= 1 )
        .slice(0,10)
    },
  },

}
</script>
