class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[create]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
