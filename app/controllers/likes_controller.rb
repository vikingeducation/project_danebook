class LikesController < ApplicationController

  before_action :get_post

  def update
    if @post
      unless @post.liked_user_ids.include?(current_user.id)
        @post.liked_users << current_user
      end
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = ["Post Does Not Exist"]
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    Like.where(post_id: params[:id], user_id: current_user.id).destroy_all
    redirect_back(fallback_location: root_path)
  end

  private
    def get_post
      @post = Post.find_by_id(params[:id])
    end
end
