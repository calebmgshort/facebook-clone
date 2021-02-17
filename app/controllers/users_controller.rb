class UsersController < ApplicationController
  def home
    @posts = current_user.own_and_friends_posts   
  end

  def profile
    @posts = current_user.own_posts
  end

  def update_profile_description
    if current_user.update(params.require(:user).permit(:description))
      redirect_to '/profile'
    else
      render '/profile/edit_description'
    end
  end

  def update_avatar
    if current_user.avatar.attach(params[:avatar])
      redirect_to '/profile'
    else
      render '/profile'
    end
  end

end