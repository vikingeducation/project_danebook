class LikesController < ApplicationController
  before_action :require_current_user

  def create
    session[:return_to] ||= request.referer
    @like = Like.new(whitelisted_like_params)
    if @like.save
      flash[:success] = "You have liked #{whitelisted_like_params[:likable_type]} 
      #{whitelisted_like_params[:likable_id]}"
    else
      flash[:error] = "This is not likable!"
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] ||= request.referer
    @like = Like.find(params[:id])
    if @like.destroy
      flash[:success] = "You have unliked it."
    else
      flash[:error] = "You have to like it!"
    end
    redirect_to session.delete(:return_to)
  end

  private

  def whitelisted_like_params
    params.permit(:user_id,
                  :likable_type,
                  :likable_id)
  end

  def require_current_user
    session[:return_to] ||= request.referer
    unless params[:user_id] == current_user.id
      flash[:warning] = "You are not authorized to do this!"
      redirect_to session.delete(:return_to)
    end
  end
end
