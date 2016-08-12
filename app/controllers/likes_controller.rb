class LikesController < ApplicationController

  def create
    session[:return_to] = request.referer
    post = extract_likeable.find(params[:post_id])
    unless post.likes.create(user_id: current_user.id)
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

    post = extract_likeable.find(params[:post_id])
    like = post.likes.where(user_id: current_user.id)
    if post.likes.destroy(like)
      redirect_to session.delete(:return_to)
    else
      flash[:alert] = "something went wrong"
      redirect_to session.delete(:return_to)
    end
  end

  private

  def extract_likeable
    params[:likeable].singularize.classify.constantize
  end
end
