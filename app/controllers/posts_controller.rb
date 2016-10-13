class PostsController < ApplicationController
  before_action :current_user_post, except: [:like, :unlike, :create]

  def create
    new_post = Post.new(whitelisted_post_params)
    if new_post.save
      flash[:success] = "Created new post!"
      redirect_to timeline_user_path(new_post.user)
    else
      @user = current_user
      @profile = @user.profile
      @post = new_post
      render 'users/timeline'
    end
  end

  def like
    @post = Post.find(params[:id])
    unless @post.likes.pluck(:user_id, :likable_id).include?([current_user.id, @post.id])
      @post.likes << Like.new(user_id: current_user.id, likable_type: "Post")
    end
    @profile = current_user.profile
    redirect_to timeline_user_path(current_user)
  end

  def unlike
    @post = Post.find(params[:id])
    if @post.likes.pluck(:user_id, :likable_id).include?([current_user.id, @post.id])
      @post.likes.destroy(@post.likes.where("user_id = #{current_user.id} AND likable_type = 'Post'"))
    end
    @profile = current_user.profile
    redirect_to timeline_user_path(current_user)
  end

  def update

  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy!
      flash[:success] = "Post deleted!"
    else
      flash[:danger] = "Unable to delete this zombie post!"
    end
    redirect_to timeline_user_path(@post.user)
  end

  private

  def whitelisted_post_params
    params.require(:post).permit(:text, :user_id)
  end

  def current_user_post
    unless signed_in_user? && params[:id] && current_user.post_ids.include?(params[:id].to_i)
      flash[:danger] = "Not authorized!"
      redirect_to timeline_user_path(current_user)
    end
  end
end
