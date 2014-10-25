class LikesController < ApplicationController
  def create
    # so they can go back thence they came
    session[:return_to] ||= request.referer
    @like = likable.likes.build(liker_id: current_user.id)
    if @like.save
      flash[:success] = "#{params[:likable].capitalize} liked"
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "An error occurred while liking"
      redirect_to session.delete(:return_to)
    end
  end

  def destroy
    session[:return_to] ||= request.referer
    @like = likable.likes.find(params[:id])
    if @like.destroy
      flash[:success] = "#{params[:likable].capitalize} unliked"
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "An error occurred while unliking"
      redirect_to session.delete(:return_to)
    end
  end

  private

  def parent_id
    params[:post_id]
  end

  def likable
    # use the params to find the appropriate model and object
    params[:likable].capitalize.constantize.find(parent_id)
  end
end
