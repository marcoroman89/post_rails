class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.creator = User.first # TODO: FIx after authentication
    
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
end  