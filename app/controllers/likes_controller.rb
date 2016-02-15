class LikesController < ApplicationController
  before_action :set_post_info, only: [:create, :destroy]
  before_action :require_login

  def create
    #@like = @post.likes.where("user_id = ?",current_user.id)
    @like = @post.likes.build(user_id: current_user.id,)
    if @like.save
       flash[:success] = "Created a like!"
    else 
      flash[:alert] = "Like Failed!"
    end
    redirect_to user_posts_path(@user.id)
  end 

  def destroy

    @like = Like.find(params[:id])
    if @like.destroy
      flash[:success] = "Unliked the commented!"
    else
      flash[:alert] = "UnLike Failed!"
    end
  
    redirect_to user_posts_path(@user.id)
  end 

  def set_post_info
    @user = User.find(params[:user_id]) 
    @post = Post.find(params[:post_id])
    @num_likes = @post.likes.count || 0 
  end

  def like_params
  end 
end
