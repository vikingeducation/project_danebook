class LikesController < ApplicationController

  def create
    @likes = current_user.likes.build(likeable_id: params[:id], likeable_type: params[:type] )
    if  @likes.save
      flash[:success] = "Liked!"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @like = current_user.likes.where(likeable_id: params[:id], likeable_type: params[:type])
    @like.first.destroy
    redirect_back(fallback_location: root_path)
  end
end
