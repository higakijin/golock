<template>
  <div>
    <p>ようこそ。こちらはログインページ</p>
    <div v-if="showLogin">
      <LoginForm />
      <p>未登録なら<span @click="showLogin = false">こちら</span>をクリック</p>
    </div>
    <div v-if="!showLogin">
      <SignupForm />
      <p>登録済なら<span @click="showLogin = true">こちら</span>をクリック</p>
    </div>
  </div>
</template>

<script>
import LoginForm from '../components/UserAuth/LoginForm.vue'
import SignupForm from '../components/UserAuth/SignupForm.vue'

export default {
  components: {LoginForm, SignupForm},
  data () {
    return {
      showLogin: true
    }
  }
}
</script>