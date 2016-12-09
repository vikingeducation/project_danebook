class LikesController < ApplicationController

  def create
    @like = Like.create(user_id: params[:user_id], thing_id: params[:thing_id])
    if  @like.save
      flash[:success] = "Liked!"
      redirect_to(:back)
    end
  end

  def destroy

  end
end
