class PostsController < ApplicationController
  def create
    current_user.posts.create!(post_params)
    redirect_to params[:return_url]
  end

  private

  def post_params
    params.require(:post).permit(:text)
  end
end
