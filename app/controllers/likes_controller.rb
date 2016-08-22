class LikesController < ApplicationController
  before_action :require_login

  def create
    if signed_in_user?
      type = params[:likeable].classify
      resource = type.constantize.find(params["#{type.downcase}_id"])
      if resource.likes.create(:user_id => current_user.id)
        flash[:success] = "Like contributed to the post!"
      else
        flash[:danger] = "Couldn't establish the like"
      end
      redirect_to :back
    else
      redirect_to login_path
    end
  end

  def destroy
    if signed_in_user?
      @like = Like.find(params[:id])
      if @like.destroy
        flash[:success] = "Unliked the post"
      else
        flash[:danger] = "Couldn't make the unlike"
      end
      redirect_to :back
    else
      redirect_to login_path
    end
  end
end
