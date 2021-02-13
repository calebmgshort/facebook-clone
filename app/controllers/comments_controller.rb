class CommentsController < ApplicationController

  def create
    validated_params = comment_params
    validated_params[:user_id] = current_user.id
    Comment.create!(validated_params)
    redirect_to params[:return_url]
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :post_id)
  end

end
