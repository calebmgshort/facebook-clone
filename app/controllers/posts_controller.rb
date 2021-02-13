class PostsController < ApplicationController
  def create
    if current_user.posts.create(post_params)
      redirect_to params[:return_url]
    else
      raise "Failed to create post"
    end
  end

  private

  def post_params
    params.require(:post).permit(:text)
  end
end
