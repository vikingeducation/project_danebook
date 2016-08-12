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
      post = extract_likeable.find(params[:post_id])
    unless post.likes.destroy(params[:id])
      flash[:alert] = "something went wrong"
    end
    redirect_to session.delete(:return_to)
  end

  private

  def extract_likeable
    params[:likeable].singularize.classify.constantize
  end

end
