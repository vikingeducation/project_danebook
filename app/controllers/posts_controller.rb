class PostsController < ApplicationController
  layout "timeline"

  before_action :require_login
  before_action :require_object_owner, only: [:destroy]


  def index
    @posts = Post.where(user_id: params[:user_id]).order(created_at: :desc)
    @user = User.find(params[:user_id])
    @new_post = current_user.posts.build if signed_in_user?
    @new_comment = Comment.new

    respond_to do |format|
      format.html
      format.js
    end
  end


  def create
    @post = Post.new(whitelisted_params)
    @post.user_id = current_user.id

    if @post.save 
      flash[:success] = "Post created"
      respond_to do |format|
        format.html
        format.js { render :create_success }
      end

    else
      flash[:error] = "Unable to save post"
      respond_to do |format|
        format.html
        format.js { render :new }
      end
    end
  end


  def destroy
    @post = Post.find(params[:id])
     if @post.destroy 
      flash[:success] = "Post deleted"
    else
      flash[:error] = "Unable to delete post"
    end
    redirect_to :back
  end




  private
  def whitelisted_params
    params.require(:post).permit(:body)
  end


end
