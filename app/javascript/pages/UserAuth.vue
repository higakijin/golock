<template>
  <div>
    <div v-if="showLogin" class="loginForm">
      <section class="text-gray-600 body-font">
        <div class="container px-5 py-64 mx-auto flex flex-wrap items-center">
          <div class="lg:w-3/5 md:w-1/2 md:pr-16 lg:pr-0 pr-0">
            <h1 class="title-font font-medium text-3xl text-gray-900">Golockにログインしてあなたの知識を世界中に伝えよう。</h1>
            <p class="leading-relaxed mt-4">
              あなたのアウトプットを待っている人がいます。いますぐ始めよう。
              <br>未登録なら<span @click="showLogin = false" class="text-blue-700 underline cursor-pointer">こちら</span>をクリック
            </p>
          </div>
          <form @submit.prevent="login" class="lg:w-2/6 md:w-1/2 bg-gray-100 rounded-lg p-8 flex flex-col md:ml-auto w-full mt-10 md:mt-0">
            <h2 class="text-gray-900 text-lg font-medium title-font mb-5">ログイン</h2>
            <div class="relative mb-4">
              <label for="email" class="leading-7 text-sm text-gray-600">メールアドレス</label>
              <input type="text" required v-model="loginEmail" class="w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out">
            </div>
            <div class="relative mb-4">
              <label for="password" class="leading-7 text-sm text-gray-600">パスワード</label>
              <input type="password" required v-model="loginPassword" class="w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out">
            </div>
            <div class="relative mb-4 text-red-500">
              {{ error }}
            </div>
            <button class="text-white bg-indigo-500 border-0 py-2 px-8 focus:outline-none hover:bg-indigo-600 rounded text-lg">登録</button>
          </form>
        </div>
      </section>
      
    </div>
    <div v-if="!showLogin" class="signupForm">
      <section class="text-gray-600 body-font">
        <div class="container px-5 py-44 mx-auto flex flex-wrap items-center">
          <div class="lg:w-3/5 md:w-1/2 md:pr-16 lg:pr-0 pr-0">
            <h1 class="title-font font-medium text-3xl text-gray-900">ようこそ、Golockへ</h1>
            <p class="leading-relaxed mt-4">
              登録してあなたのアウトプットを公開しましょう。あなたの知識を求めている人がいます。
              <br>登録済なら<span @click="showLogin = true" class="text-blue-700 underline cursor-pointer">こちら</span>をクリック
            </p>
          </div>
          <form @submit.prevent="signUp" class="lg:w-2/6 md:w-1/2 bg-gray-100 rounded-lg p-8 flex flex-col md:ml-auto w-full mt-10 md:mt-0">
            <h2 class="text-gray-900 text-lg font-medium title-font mb-5">サインアップ</h2>
            <div class="relative mb-4">
              <label for="name" class="leading-7 text-sm text-gray-600">名前</label>
              <input type="text" v-model="signupName" class="w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out">
            </div>
            <div class="relative mb-4">
              <label for="email" class="leading-7 text-sm text-gray-600">メールアドレス</label>
              <input type="email" v-model="signupEmail" class="w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out">
            </div>
            <div class="relative mb-4">
              <label for="password" class="leading-7 text-sm text-gray-600">パスワード</label>
              <input type="password" v-model="signupPassword" class="w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out">
            </div>
            <div class="relative mb-4">
              <label for="password_confirmation" class="leading-7 text-sm text-gray-600">パスワード（確認用）</label>
              <input type="password" v-model="signupPasswordConfirmation" class="w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out">
            </div>
            <button class="text-white bg-indigo-500 border-0 py-2 px-8 focus:outline-none hover:bg-indigo-600 rounded text-lg">登録</button>
          </form>
        </div>
      </section>
    </div>

  </div>
</template>

<script>
// import LoginForm from '../components/UserAuth/LoginForm.vue'
// import SignupForm from '../components/UserAuth/SignupForm.vue'
import axios from 'axios'

export default {
  // components: {LoginForm, SignupForm},
  data () {
    return {
      showLogin: true,

      loginEmail: '',
      loginPassword: '',

      signupName: '',
      signupEmail: '',
      signupPassword: '',
      signupPasswordConfirmation: '',
      error: null
    }
  },
  methods: {
    async login() {
      this.error = null
      try {
        const res = await axios.post('http://localhost:3000/auth/sign_in', {
          email: this.loginEmail,
          password: this.loginPassword
        })
        if (!res) {
          throw new Error('ログインできませんでした')
        }
        console.log({res});
        return res
      } catch (error) {
        this.error = 'ログインできませんでした'
      }
    },
    async signUp() {
      this.error = null
      try {
        const res = await axios.post('http://localhost:3000/auth', {
          name: this.signupName,
          email: this.signupEmail,
          password: this.signupPassword,
          password_confirmation: this.signupPasswordConfirmation,
        })
        if (!res) {
          throw new Error('サインアップできませんでした。')
        }
        console.log({res});
        return res
      } catch (error) {
        this.error = 'サインアップできませんでした。'
      }
    }
  }
}
</script>