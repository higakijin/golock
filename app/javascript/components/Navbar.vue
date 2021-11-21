<template>
  <nav class="flex items-center justify-between flex-wrap bg-green-500 p-4">
    <div class="flex items-center flex-shrink-0 text-white mr-6">
      <svg class="fill-current h-8 w-8 mr-2" width="54" height="54" viewBox="0 0 54 54" xmlns="http://www.w3.org/2000/svg"><path d="M13.5 22.1c1.8-7.2 6.3-10.8 13.5-10.8 10.8 0 12.15 8.1 17.55 9.45 3.6.9 6.75-.45 9.45-4.05-1.8 7.2-6.3 10.8-13.5 10.8-10.8 0-12.15-8.1-17.55-9.45-3.6-.9-6.75.45-9.45 4.05zM0 38.3c1.8-7.2 6.3-10.8 13.5-10.8 10.8 0 12.15 8.1 17.55 9.45 3.6.9 6.75-.45 9.45-4.05-1.8 7.2-6.3 10.8-13.5 10.8-10.8 0-12.15-8.1-17.55-9.45-3.6-.9-6.75.45-9.45 4.05z"/></svg>
      <router-link to="/"><span class="font-semibold text-xl tracking-tight">Golock</span></router-link>
    </div>
    <div class="block lg:hidden">
      <button @click="openBar" class="flex items-center px-3 py-2 border rounded text-teal-200 border-teal-400 hover:text-white hover:border-white">
        <svg class="fill-current h-3 w-3" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><title>Menu</title><path d="M0 3h20v2H0V3zm0 6h20v2H0V9zm0 6h20v2H0v-2z"/></svg>
      </button>
    </div>
    <div class="w-full block flex-grow lg:flex lg:items-center lg:w-auto">
      <div class="text-sm lg:flex-grow">
        <a href="#responsive-header" class="block mt-4 lg:inline-block lg:mt-0 text-teal-200 hover:text-white mr-4">
          Docs
        </a>
        <a href="#responsive-header" class="block mt-4 lg:inline-block lg:mt-0 text-teal-200 hover:text-white mr-4">
          Examples
        </a>
        <a href="#responsive-header" class="block mt-4 lg:inline-block lg:mt-0 text-teal-200 hover:text-white mr-4">
          Blog
        </a>
        <router-link to="/posts/new"
          class="block mt-4 lg:inline-block lg:mt-0 text-teal-200 hover:text-white mr-4"
          :class="this.$route.path==='/posts/new' ? 'text-white' : '' "
        >
          投稿する
        </router-link>
      </div>

      <div v-if="isCurrentUser">
        <button @click="logout" class="inline-block text-sm px-4 py-2 leading-none border rounded text-white border-white hover:border-transparent hover:text-green-600 hover:bg-white mt-4 lg:mt-0 hover:cursor-pointer">ログアウト</button>
      </div>
      <div v-else>
        <router-link to="/users/auth" class="inline-block text-sm px-4 py-2 leading-none border rounded text-white border-white hover:border-transparent hover:text-green-600 hover:bg-white mt-4 lg:mt-0">
          ログイン
        </router-link>
      </div>
    </div>
  </nav>

</template>

<script>
import axios from 'axios'

export default {
  data () {
    return {
      isEnable: false,
      isCurrentUser: false,
      error: null
    }
  },
  methods: {
    openBar () {
      this.isEnable = !this.isEnable
    },
    async logout () {
      this.error = null
      try {
        const res = await axios.delete('http://localhost:3000/auth/sign_out', {
          headers: {
            uid: window.localStorage.getItem('uid'),
            "access-token": window.localStorage.getItem('access-token'),
            client: window.localStorage.getItem('client')
          }
        })
        if (!res) {
          new Error('ログアウトできませんでした。')
        }
        if (!this.error) {
          window.localStorage.removeItem('access-token')
          window.localStorage.removeItem('client')
          window.localStorage.removeItem('uid')
          window.localStorage.removeItem('name')
          this.$router.push({ name: 'UserAuth' })
        }
        this.error = null

        return res
      } catch (error)  {
        this.error = 'ログアウトできませんでした。'
        window.localStorage.removeItem('access-token')
        window.localStorage.removeItem('client')
        window.localStorage.removeItem('uid')
        window.localStorage.removeItem('name')
        this.$router.push({ name: 'UserAuth' })
      }
    },
  },
  mounted () {
    const loginJudge = () => {
      if (window.localStorage.getItem('access-token') && window.localStorage.getItem('client') && window.localStorage.getItem('uid') ) {
        this.isCurrentUser = true
      } else {
        this.isCurrentUser = false
      }
    }
    loginJudge ()
  }

}
</script>