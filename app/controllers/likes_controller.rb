class LikesController < ApplicationController

  


  def create
    @like = Like.new(like_params)
    @like.user_id = current_user.id
    if @like.save!
      flash[:success] = "You've liked the post!"
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = "Could not like that post"
      render :back
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if current_user.id == @like.user_id && @like.destroy
      flash[:success] = "You've unliked the post!"
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = "Coult not unlike that post"
      render :back
    end
  end

  private

  def like_params
    params.permit(:likeable_type, :likeable_id)
  end

  




 
end
