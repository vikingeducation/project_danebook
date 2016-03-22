class PostsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  before_action :require_post_author, only: [:destroy]

  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html {
          flash[:success] = "You've created a post!"
          redirect_to user_path(current_user) }
        format.js {
          flash.now[:success] = "You've created a post!"
        }
      else
        format.html {
          flash.now[:danger] = "Failed to create a post!"
          @user = current_user
          @profile = current_user.profile
          @posts = current_user.posts.order("created_at DESC")
          render 'users/show'
        }
        format.js {
          flash.now[:danger] = "Failed to create a post!"
          @user = current_user
          @profile = current_user.profile
          @posts = current_user.posts.order("created_at DESC")
          render 'users/show'
        }
      end
    end
  end

  def destroy
    @post = current_user.posts.find_by_id(params[:id])
    if @post.destroy
      flash[:success] = "You've deleted a post!"
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = "Failed to delete a post!"
      @user = current_user
      @profile = current_user.profile
      @posts = current_user.posts.order("created_at DESC")
      render "users/show"
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def require_post_author
    posty = Post.find_by_id(params[:id])
    unless posty && posty.user_id == current_user.id
      flash[:danger] = "You're not the post's author!!!"
      redirect_to user_path(current_user)
    end
  end
end
