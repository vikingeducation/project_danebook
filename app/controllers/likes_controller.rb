class LikesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @user = @post.user
    @like = Like.create(:post_id => params[:post_id],
                :user_id => current_user.id)
    @like.save
    redirect_to user_posts_path(@user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @user = @post.user
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to user_posts_path(@user)
  end

end
