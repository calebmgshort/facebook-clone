class UsersController < ApplicationController
  def home
    @posts = Post.joins(:user).select(:text, :email, :created_at).order(created_at: :desc).where(user_id: current_user.id)
  end
end