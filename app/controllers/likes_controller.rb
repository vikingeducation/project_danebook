class LikesController < ApplicationController

  def create
    @likes = current_user.likes.build(likeable_id: params[:post_id], likeable_type: params[:type] )
    if  @likes.save
      flash[:success] = "Liked!"
      redirect_to(:back)
    end
  end

  def destroy
    @like = current_user.likes.where(likeable_type: params[:id], likeable_type: params[:type])
    @like.first.destroy
    redirect_to(:back)
  end
end
