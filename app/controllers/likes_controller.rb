class LikesController < ApplicationController
  before_action :require_login
  
  def create
    session[:return_to] = request.referer
    if signed_in_user?
      type = params[:likeable].classify
      resource = type.constantize.find(params["#{type.downcase}_id"])
      if resource.likes.create(:user_id => current_user.id)
        flash[:success] = "Like contributed to the post!"
      else
        flash[:error] = "Couldn't establish the like"
      end
      redirect_to session.delete(:return_to)
    else
      redirect_to login_path
    end
  end

  def destroy
    session[:return_to] = request.referer
    if signed_in_user?
      @like = Like.find(params[:id])
      if @like.destroy
        flash[:success] = "Unliked the post"
      else
        flash[:error] = "Couldn't make the unlike"
      end
      redirect_to session.delete(:return_to)
    else
      redirect_to login_path
    end
  end
end
