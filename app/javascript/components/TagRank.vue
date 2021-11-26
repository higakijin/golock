<template>
  <div>
    <h2>タグ・ランキング</h2>
    <table>
      <tbody v-for='(tag, index) in sortedTagsByCount' :key='tag.id'>
        <tr>
          <th>{{ checkRank(tags[index-1], tag, index) }}位</th>
          <th>{{ tag.name }}</th>
          <th>{{ tag.count }}件</th>
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
    },
  },

}
</script>
