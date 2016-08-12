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
    unless params[:id] == current_user.id.to_s
      flash[:error] = "You're not authorized to delete this"
      redirect_to session.delete(:return_to)
    end

    likeable = extract_likeable.find(params[:likeable_id])
    like = likeable.likes.where(user_id: current_user.id)
    if likeable.likes.destroy(like)
      redirect_to session.delete(:return_to)
    else
      flash[:alert] = "something went wrong"
      redirect_to session.delete(:return_to)
    end
  end

  private

  def extract_likeable
    params[:likeable_type].singularize.classify.constantize
  end
end
