class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update] # index消した

  def index
    posts = Post.all.includes(:user)
    posts_array = posts.map do |p|
      {
        id: p.id,
        user_id: p.user.id,
        email: p.user.email,
        name: p.user.name,
        title: p.title,
        body: p.body,
        published: p.published,
        created_at: p.created_at
      }
    end
    render json: posts_array, status: 200
  end

  def create
    current_user = User.find_by(email: params['uid'])
    post = Post.new(title: params['post'][:title], body: params['post'][:body], user_id: current_user.id)
    if params["published"] == true
      post.published = true
    else
      post.published = false
    end
    post.save
    render json: post
  end
  
  def show 
    p = Post.find(params[:id])
    u = User.find(p.user_id)
    post_array = {
      id: p.id,
      title: p.title,
      body: p.body,
      created_at: p.created_at,
      updated_at: p.updated_at,

      user_id: u.id,
      name: u.name,
      uid: u.email,
    }
    render json: post_array, status: 200
  end

  def update
    post = Post.find(params[:id])
    title = params['post'][:title]
    body = params['post'][:body]
    if params[:published] == true
      published = true
    else 
      published = false
    end
    post.update(title: title, body: body, published: published)
    render json: post
  end

end
