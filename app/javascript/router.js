import Vue from 'vue'
import Router from 'vue-router'
import '../javascript/css/application.css'

import UserAuth from '../javascript/pages/UserAuth.vue'
import Posts from '../javascript/pages/Posts.vue'
import PostNew from '../javascript/pages/PostNew.vue'
import PostShow from '../javascript/pages/PostShow.vue'
import PostEdit from '../javascript/pages/PostEdit.vue'
import PostUnpublished from '../javascript/pages/PostUnpublished.vue'
import TagLists from '../javascript/pages/TagLists.vue'

import mavonEditor from 'mavon-editor'
import 'mavon-editor/dist/css/index.css'

import { library } from '@fortawesome/fontawesome-svg-core'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import { fas } from '@fortawesome/free-solid-svg-icons'
import { fab } from '@fortawesome/free-brands-svg-icons'
import { far } from '@fortawesome/free-regular-svg-icons'

import useValidate from '../javascript/auth/validate'

Vue.use(Router)
Vue.use(require('vue-moment'))

Vue.use(mavonEditor)

library.add(fas, far, fab)
Vue.component('font-awesome-icon', FontAwesomeIcon)

const { validate } = useValidate()
const requireAuth = async (to, from, next) => {
  const uid = window.localStorage.getItem('uid')
  const client = window.localStorage.getItem('client')
  const accessToken = window.localStorage.getItem('access-token')

  if (!uid || !client || !accessToken) {
    // console.log('ログインしていません')
    next({ name: 'UserAuth' })
    return
  }

  await validate()

  next()
}

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
    // { path: '/', name: 'Home', component: Home },
    { path: '/users/auth', name: 'UserAuth', component: UserAuth },
    { path: '/', name: 'Posts', component: Posts },
    { path: '/posts/new', name: 'PostNew', component: PostNew, beforeEnter: requireAuth },
    { path: '/posts/unpublished', name: 'PostUnpublished', component: PostUnpublished, beforeEnter: requireAuth },
    { path: '/posts/:id', name: 'PostShow', component: PostShow },
    { path: '/posts/:id/edit', name: 'PostEdit', component: PostEdit, beforeEnter: requireAuth },
    { path: '/posts/tags/:tag_name', name: 'TagLists', component: TagLists }
    
    // {
    //   path: '/article/:id',
    //   name: 'Article',
      
    //   // 非同期でコンポーネントを呼び出す
    //   // ※Homeのようにimportしたコンポーネントを設定するのでも可
    //   component: () => import('./components/article.vue')
    // },

  ],
  scrollBehavior (to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return { x: 0, y: 0 }
    }
  }
  
})