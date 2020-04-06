class CommentsController < ApplicationController
  def show
    @post = Post.find_by(id: params[:id])
  end
  
  def create
    @post = Post.find_by(id: params[:id])
    Comment.create(text: comment_params[:text], post_id: comment_params[:id], user_id: @current_user.id)
    redirect_to("/posts/#{@post.id}")
  end
  
  private
  def comment_params
    params.permit(:text, :id)
  end
end
