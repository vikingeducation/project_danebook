class LikesController < ApplicationController

  def create
    @like = current_user.likes.build(like_params)
    if @like.save
      flash[:success] = "You have created new like"
      redirect_to user_timeline_path(@like.user_id)
    else
      flash[:danger] = "Something went wrong! No likes created!"
      redirect_to user_timeline_path(@like.user_id)
    end
  end

  def destroy
    @like = Like.all.where(like_params)[0]
    if @like.destroy
      flash[:success] = "You have unliked successfully!"
      redirect_to user_timeline_path(current_user.id)
    else
      flash.now[:danger] = "Unliking didn't work :("
      redirect_to :back
    end
  end

  private
  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end

end
