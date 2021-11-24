class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update] # index消した

  def index
    posts = Post.all.includes(:user, :tags)
    posts_array = posts.map do |p|
      {
        id: p.id,
        user_id: p.user.id,
        email: p.user.email,
        name: p.user.name,
        title: p.title,
        published: p.published,
        created_at: p.created_at,
        tags: p.tags.map do |t|
          {
            id: t.id,
            name: t.name
          }
        end
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
    params[:tags][:name].each do |tag|
      Tag.create(name: tag) unless Tag.find_by(name: tag)
      PostTag.create(post_id: post.id, tag_id: Tag.find_by(name: tag).id)
    end
    render json: post
  end
  
  def show 
    p = Post.find(params[:id])
    u = User.find(p.user_id)
    post_array = {
      id: p.id,
      title: p.title,
      body: p.body,
      published: p.published,
      created_at: p.created_at,
      updated_at: p.updated_at,

      user_id: u.id,
      name: u.name,
      uid: u.email,

      tags: p.tags.map do |t| 
        {
          id: t.id,
          name: t.name
        } 
      end
    }
    render json: post_array, status: 200
  end

  def update
    post = Post.find(params[:id])
    if params['post'][:title] && params['post'][:body]
      title = params['post'][:title]
      body = params['post'][:body]
    else
      title = post.title
      body = post.body
    end

    if params[:published] == true
      published = true
    else 
      published = false
    end
    
    if params[:tags][:name] #タグの追加
      params[:tags][:name].each do |tag|
        if t = Tag.find_by(name: tag)
          PostTag.create(post_id: post.id, tag_id: t.id) unless PostTag.find_by(post_id: post.id, tag_id: t.id)
        else
          t = Tag.create(name: tag)
          PostTag.create(post_id: post.id, tag_id: t.id)
        end
      end
    end

    post.tags.each do |t| #タグの削除
      unless params[:tags][:name].include?(t[:name])
        PostTag.find_by(post_id: post.id, tag_id: Tag.find_by(name: t[:name]).id).destroy
      end
    end

    post.update(title: title, body: body, published: published)
    render json: post
  end

end
