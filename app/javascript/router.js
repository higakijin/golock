import Vue from 'vue'
import Router from 'vue-router'
import '../javascript/css/application.css'
import Home from '../javascript/pages/Home.vue'
import UserAuth from '../javascript/pages/UserAuth.vue'
import PostNew from '../javascript/pages/PostNew.vue'
import Welcome from '../javascript/pages/Welcome.vue'
import Posts from '../javascript/pages/Posts.vue'

// import useValidate from '../javascript/auth/validate'

Vue.use(Router)
Vue.use(require('vue-moment'));
// const { validate } = useValidate()

// const requireAuth = async (to, from, next) => {
//   const uid = window.localStorage.getItem('uid')
//   const client = window.localStorage.getItem('client')
//   const accessToken = window.localStorage.getItem('access-token')

//   if (!uid || !client || !accessToken) {
//     console.log('ログインしていません')
//     next({ name: 'Home' })
//     return
//   }

//   await validate()

//   next()
// }

export default new Router({
  
  // modeのデフォルトは「hashモード」です。
  mode: 'history',

  // 1. hashモード
  // routes.rbの設定は不要です。
  
  // [URLの例]
  // http://localhost:3000/#/
  // http://localhost:3000/#/article/5
  // http://localhost:3000/#/article/33
  
  // 2. historyモード
  // routes.rbの設定が必要です。
  
  // [URLの例]
  // http://localhost:3000/
  // http://localhost:3000/article/5
  // http://localhost:3000/article/33
  
  // 3. abstractモード
  // 詳細は公式サイトへ https://router.vuejs.org/ja/api/#mode 
  
  // アプリのベースURL 
  base: process.env.BASE_URL,
  
  // ルーターの設定
  routes: [
    { path: '/', name: 'Home', component: Home },
    { path: '/users/auth', name: 'UserAuth', component: UserAuth },
    {
      path: '/posts', name: 'Posts', component: Posts
      // , beforeEnter: requireAuth
    },
    { path: '/posts/new', name: 'PostNew', component: PostNew },
    // {
    //   path: '/article/:id',
    //   name: 'Article',
      
    //   // 非同期でコンポーネントを呼び出す
    //   // ※Homeのようにimportしたコンポーネントを設定するのでも可
    //   component: () => import('./components/article.vue')
    // },
    {
      path: '/welcome',
      name: 'Welcome',
      component: Welcome
    }
  ]
  
})