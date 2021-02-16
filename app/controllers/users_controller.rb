class UsersController < ApplicationController
  def home
    @posts = Post.joins(:user).select("posts.id as id", :text, :email, :created_at).order(created_at: :desc).where(user_id: current_user.id)    
  end

  def profile
    @posts = Post.joins(:user).select("posts.id as id", :text, :email, :created_at).order(created_at: :desc).where(user_id: current_user.id)  
  end

  def update_profile_description
    if current_user.update(params.require(:user).permit(:description))
      redirect_to '/profile'
    else
      render '/profile/edit_description'
    end
  end

end