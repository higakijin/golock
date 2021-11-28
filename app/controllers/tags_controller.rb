class TagsController < ApplicationController
  def index
    tags = Tag.all.includes(:posts, :post_tags)
    tags_array = tags.map do |t|
      {
        id: t.id,
        name: t.name,
        count: t.posts.length
      }
    end
    render json: tags_array, status: 200
  end
end
