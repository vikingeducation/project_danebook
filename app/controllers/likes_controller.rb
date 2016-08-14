class LikesController < ApplicationController

  def create
    session[:return_to] = request.referer
    likeable = extract_likeable.find(params[:likeable_id])
    unless likeable.likes.create(user_id: current_user.id)
      flash[:alert] = "something went wrong"
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] = request.referer
    likeable = extract_likeable.find(params[:likeable_id])
    if like = likeable.likes.where(user_id: current_user.id)
      flash[:alert] = "something went wrong" unless likeable.likes.destroy(like)
    else
      flash[:error] = "You're not authorized to delete this"
    end
    redirect_to session.delete(:return_to)
  end

  private

  def extract_likeable
    params[:likeable_type].singularize.classify.constantize
  end
end
