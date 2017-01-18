class LikesController < ApplicationController

  def create
    @likes = current_user.likes.build(likeable_id: params[:id], likeable_type: params[:type] )

    respond_to do |format|
      if  @likes.save
        format.html {redirect_back(fallback_location: root_path)}
        format.js {}
        flash[:success] = "Liked!"
      else 
        format.html {redirect_back(fallback_location: root_path)}
        format.js {redirect_back(fallback_location: root_path)}
        flash[:danger] = "????"
      end
    end
  end

  def destroy
    @like = current_user.likes.where(likeable_id: params[:id], likeable_type: params[:type])
    respond_to do |format|
      unless @like.empty?
        format.html {redirect_back(fallback_location: root_path)}
        format.js {}
        @like.first.destroy
      else
        format.html {redirect_back(fallback_location: root_path)}
        format.js {}
        flash[:danger] = "Unathorized Action!"
      end
    end
  end
end
