class UsersController < ApplicationController
  def index
    users = User.all
    users_array = users.map do |u|
      {
        id: u.id,
        email: u.email,
        name: u.name,
        introduction: u.introduction
      }
    end
    render json: users_array, status: 200
  end

  def show
    u = User.find(params[:id])
    user_array = {
      id: u.id,
      email: u.email,
      name: u.name,
      introduction: u.introduction
    }
    render json: user_array, status: 200
  end
end
