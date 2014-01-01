class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :vote]
  before_action :require_user, except: [:index, :show]



  def index
     @posts = Post.all.page(params[:page]).order("created_at DESC").per_page(4)
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "Your post was created!"
      redirect_to posts_path
    else
      render :new
    end  
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "You updated the post!"
      redirect_to post_path(@post)
    else
      render :edit
    end  
  end

  def destroy
    if @post.destroy
      flash[:notice] = "You successfully deleted your post!"
      redirect_to posts_path
    end
  end

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote was counted."
        else
          flash[:error] = 'You can only vote on a post once.'
        end
        redirect_to :back
      end
      format.js
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end  