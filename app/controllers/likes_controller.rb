class LikesController < ApplicationController

  def create
    @like = Like.new({post_id: params[:post_id], user_id: current_user.id})
    flash[:alert] = "You already liked this post, no need to do it again" unless @like.save
    redirect_to timeline_path
  end

  def destroy
    @like = Like.search_record(params[:post_id], current_user.id)
    if @like
      @like.destroy
    else
      flash[:alert] = "You already unliked this post, no need to do it again"
    end
    redirect_to timeline_path
  end


end
