class LikesController < ApplicationController

  before_action :require_login

  def create
    if params[:likeable_type] == "Post"
      likeable = Post.find(params[:likeable_id])
      like = likeable.likes.new
    else
      likeable = Comment.find(params[:likeable_id])
      like = likeable.likes.new
    end
    
    like.user_id = current_user.id if current_user
    if like.save
      redirect_to request.referrer
    else
      flash[:error] = "Could not like this. Please try again"
      redirect_to request.referrer
    end
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
    redirect_to request.referrer
  end

  private

  def require_login
    unless current_user
      flash[:error] = "You must be logged in"
      redirect_to root_path # halts request cycle
    end
  end

end
