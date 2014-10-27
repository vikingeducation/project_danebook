class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post])
    @like = @post.likes.build(:user_id => current_user.id)

      if @post.save!
        flash[:success] = "You'll like just about anything, won't you?"
        redirect_to user_timeline_url(@post.user)
      else
        flash[:error] = "Like failed."
        redirect_to user_timeline_url(@post.user)
      end
  end

  def destroy
    @post = Post.find(params[:post])
    @like = Like.find(params[:id])
      if @like.destroy!
        flash[:success] = "You so cold. Unlike successful"
        redirect_to user_timeline_url(@post.user)
      else
        flash[:error] = "That unlike didn't work...that'll teach you to drink and like!"
        redirect_to user_timeline_url(@post.user)
      end
  end


end
