<template>
  <!-- <table>
    <tbody v-for='(tag, index) in tags' :key='tag.id'>
      <tr>
        <th>{{ index+1 }}位</th>
        <th>{{ tag.name }}</th>
        <th>{{ tag.count }}件</th>
      </tr>
    </tbody>
  </table> -->
  <div>
    <div v-for='tag in tags' :key='tag.id'>
      <p>{{ tag.name }}</p>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data() {
    return {
      tags: []
    }
  },
  methods: {
    async getTagData() {
      try {
        const res = await axios.get('http://localhost:3000/api/tag', {})
        if (!res) {
          new Error('メッセージを取得できませんでした。')
        }
        this.tags = res.data
        console.log(res);
      } catch (error) {

      }
    },

    async getPosts () {
      try {
        const res = await axios.get('http://localhost:3000/api/posts', {})
        if (!res) {
          new Error('メッセージを取得できませんでした。')
        }
        console.log(res);
        this.posts = res.data.filter((v) => v.published).reverse()
      } catch (error) {
        // メッセージを取得できませんでした。
      }
    },
  },
  mounted() {
    this.getTagData()
  }
}
</script>
