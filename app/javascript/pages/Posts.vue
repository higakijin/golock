<template>
  <div>
    <Navbar />
    <div class="grid grid-cols-7 gap-4">
      <div class="col-span-1">

      </div>
      <div class="col-span-4">
        <PostLists />
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

export default {
  components: { Navbar, PostLists, TagRank }
}
</script>