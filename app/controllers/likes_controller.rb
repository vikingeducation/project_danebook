class LikesController < ApplicationController

  skip_before_action :correct_user
  before_action :correct_like

  def destroy
    like = Like.find(params[:id])
    parent = like.likeable
    like.destroy
    flash[:success] = "#{parent.class} unliked."
    redirect_to timeline_path(parent.user.timeline.id)
  end

end
