class PostsController < ApplicationController
  def index
    posts = Post.all
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


end
