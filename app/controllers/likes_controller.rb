class LikesController < ApplicationController

  def create
    @like = current_user.likes.build(like_params)
    if @like.save
      flash[:success]
      redirect_back(fallback_location: root_path)
    else
      flash[:warning]
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
  end

  private

  def like_params
    params.require(:like).permit(:likable_type, :likable_id)
  end

end
