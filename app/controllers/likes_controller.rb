class LikesController < ApplicationController

  def new
    @like = User.likes.build
  end

  def create
    @like = current_user.likes.build(like_params)
    session[:return_to] ||= request.referer
    if @like.save
      redirect_to session.delete(:return_to)
      flash[:success] = "Liked the post!"
    else
      current_user.likes.build
      flash.now[:error] = "Failed to like the post"
      # redirect_to user_posts_path(@like.user)
      redirect_to session.delete(:return_to)
    end
  end

  def destroy
    session[:return_to] ||= request.referer
    @like = Like.find(params[:id])

    if @like.destroy
      flash[:success] = "Unliked item successfully."
      redirect_to session.delete(:return_to)
      # redirect_to user_posts_path(@like.user)
    else
      flash[:error] = "Item unlike didn't work"
      redirect_to session.delete(:return_to)
      # redirect_to session.delete(:return_to)
    end
  end

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type, :user_id)
  end
end
