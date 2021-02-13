class UsersController < ApplicationController
  def home
    # TODO: Run an actual sequal query with posts and comments grouped by comments. The current queries are inefficient.
    @posts = Post.joins(:user).select("posts.id as id", :text, :email, :created_at).order(created_at: :desc).where(user_id: current_user.id)
  end
end