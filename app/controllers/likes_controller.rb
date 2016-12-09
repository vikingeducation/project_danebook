class LikesController < ApplicationController

  before_action :get_post

  def update
    if @post
      @post.liked_user_ids << current_user.id
      if @post.save
        redirect_back(fallback_location: root_path)
      else
        flash[:danger] = @post.errors.full_messages
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:danger] = ["Post Does Not Exist"]
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
  end

  private
    def get_post
      @post = Post.find_by_id(params[:id])
    end
end
