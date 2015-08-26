class LikesController < ApplicationController
  before_action :require_login

  def new
    @like = Like.new(whitelisted_like_params)
  end

  def create
    @like = Like.new(whitelisted_like_params)
    if @like.save
      flash[:success] = "You liked the post!"
    else
      flash[:error] = "Unable to process like"
    end
    redirect_to URI(request.referer).path
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.destroy
      flash[:success] = "Unliked the post"
    else
      flash[:error] = "Unable to process"
    end
  redirect_to URI(request.referer).path
  end

  private

  def whitelisted_like_params
    params.require(:like).permit(:user_id, :likeable_id, :likeable_type)
  end

end
