class LikesController < ApplicationController

  skip_before_action :correct_user
  before_action :correct_like

  def destroy
    like = Like.find(params[:id])
    parent = like.likeable.class
    like.destroy
    flash[:success] = "#{parent} unliked."
    redirect_to timeline_path(current_user.timeline.id)
  end

end
