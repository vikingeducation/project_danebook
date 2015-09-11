class LikesController < ApplicationController
  before_action :require_current_user,  only: [:create]

  def create
    session[:return_to] ||= request.referer
    @like = Like.new(whitelisted_like_params)
    if @like.save
      flash[:success] = "You have liked #{whitelisted_like_params[:likable_type]} 
      #{whitelisted_like_params[:likable_id]}"
      respond_to do |format|
        format.html { redirect_to session.delete(:return_to) }
        format.js { render :action_success }
      end
    else
      flash[:error] = "This is not likable!"
      respond_to do |format|
        format.html { redirect_to session.delete(:return_to) }
      end
    end
    
  end

  def destroy
    session[:return_to] ||= request.referer
    @like = Like.find(params[:id])
    if @like.user == current_user && @like.destroy
      flash[:success] = "You have unliked it."
      respond_to do |format|
        format.html { redirect_to session.delete(:return_to) }
        format.js { render :action_success }
      end
    else
      flash[:error] = "You have to like it!"
      respond_to do |format|
        format.html { redirect_to session.delete(:return_to) }
      end
    end
  end

  private

  def whitelisted_like_params
    params.permit(:user_id,
                  :likable_type,
                  :likable_id)
  end

  def require_current_user
    session[:return_to] ||= request.referer
    unless params[:user_id] == current_user.id.to_s
      flash[:warning] = "You are not authorized to do this!"
      redirect_to session.delete(:return_to)
    end
  end
end
