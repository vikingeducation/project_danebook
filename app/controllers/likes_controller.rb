class LikesController < ApplicationController

  def create
    @likes = current_user.likes.build(likeable_id: params[:id], likeable_type: params[:type] )

    if  @likes.save
      flash[:success] = "Liked!"
    else 
      flash[:danger] = "????"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = current_user.likes.where(likeable_id: params[:id], likeable_type: params[:type])

    unless @like.empty?
      @like.first.destroy
    else
      flash[:danger] = "Unathorized Action!"
    end
    redirect_back(fallback_location: root_path)
  end
end
