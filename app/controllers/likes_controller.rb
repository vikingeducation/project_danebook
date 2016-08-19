class LikesController < ApplicationController

  def create
    @likeable = params[:post_id] ? Post.find(params[:post_id]) : Comment.find(params[:comment_id])
    @likeable.likes.create(user_id: current_user.id)
    redirect_back(fallback_location: root_url)
  end

  def destroy
    Like.find(params[:id]).destroy
    redirect_back(fallback_location: root_url)
  end

end
