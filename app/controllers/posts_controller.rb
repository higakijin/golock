class PostsController < ApplicationController
  # before_action :authenticate_user!, only: [:create] # index消した

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
    current_user = User.find_by(email: params['headers']['uid'])
    post = Post.new(title: params[:title], body: params[:body], user_id: current_user.id)
    post.save
    render json: post
  end

  # private

  #   def post_params
  #     params.require(:posts).permit(:title, :body)
  #   end
end
