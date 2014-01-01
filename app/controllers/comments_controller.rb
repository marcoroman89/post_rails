class CommentsController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.creator = current_user
    
   # @comment = @post.comments.build(params.require(:comment).permit(:body))

    if @comment.save
      flash[:notice] = "You created a comment!"
      redirect_to post_path(@post)
    else
      render "posts/show"
    end  
  end

  def destroy
    
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end  