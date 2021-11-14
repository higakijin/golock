<template>
  <div>
    <Navbar />
    <form>
      <input type="text" v-model="title" placeholder="タイトルを入力">
      <input type="text" v-model="body" placeholder="本文を入力">
      <button>投稿！</button>
    </form>
  </div>
</template>

<script>
import Navbar from '../components/Navbar.vue'

export default {
  components: {Navbar}
  
}
</script>