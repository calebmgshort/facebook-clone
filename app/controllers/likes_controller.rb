class LikesController < ApplicationController
  def create
    Like.create!(like_params)
    redirect_to params[:return_url]
  end

  def destroy
    Like.where(user_id: params['user_id'], post_id: params['post_id']).destroy_all
    redirect_to params[:return_url]
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
