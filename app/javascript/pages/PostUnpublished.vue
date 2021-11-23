<template>
  <div>
    <Navbar />
    <div class="grid grid-cols-7 gap-4">
      <div class="col-span-1">

      </div>
      <div class="col-span-5">
        <PostUnpublishedLists />
      </div>
      <div class="col-span-1"></div>
    </div>
    
  </div>
</template>

<script>
import Navbar from '../components/Navbar.vue'
import PostUnpublishedLists from '../components/PostUnpublishedLists.vue'

export default {
  components: { Navbar, PostUnpublishedLists },

}
</script>

<style>

</style>