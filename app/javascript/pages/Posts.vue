<template>
  <div>
    <Navbar />
    <PostLists />
  </div>
</template>

<script>
import Navbar from '../components/Navbar.vue'
import PostLists from '../components/PostLists.vue'

export default {
  components: { Navbar, PostLists }
}
</script>