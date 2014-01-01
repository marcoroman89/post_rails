class CommentsController < ApplicationController
  before_action :require_user, only: [:new, :create, :destroy]

  def create
    @post = Post.find_by slug: params[:post_id]
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

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote was counted!"
        else
          flash[:error] = "You can only vote on a comment once!"
        end   
        redirect_to :back
      end
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end  