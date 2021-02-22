class UserFriendController < ApplicationController
  def request_friend
    validated_params = request_friend_params
    validated_params[:requester_id] = current_user.id
    validated_params[:accepted] = false
    UserFriend.create!(validated_params)
    flash[:notice] = "Friend request sent"
    redirect_to params[:return_url]
  end

  def accept_friend
    validated_params = respond_friend_params
    validated_params[:requestee_id] = current_user.id
    UserFriend.find_by(requester_id: validated_params[:requester_id], requestee_id: current_user.id).update!(accepted: true)
    flash[:notice] = "Friend request accepted"
    redirect_to params[:return_url]
  end

  def reject_friend
    validated_params = respond_friend_params
    UserFriend.find_by(requester_id: validated_params[:requester_id], requestee_id: current_user.id).destroy!
    flash[:notice] = "Friend request rejected"
    redirect_to params[:return_url]
  end

  def remove_friend
    friend_id = params['friend_id']
    user_id = current_user.id
    UserFriend.remove_friend(user_id, friend_id)
    flash[:notice] = "Friend removed"
    redirect_to params[:return_url]
  end

  private 

  def request_friend_params
    params.require(:user_friend).permit(:requestee_id)
  end

  def respond_friend_params
    params.require(:user_friend).permit(:requester_id)
  end

end
