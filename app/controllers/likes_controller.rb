class LikesController < ApplicationController

  def create
    @like = Like.new(user_id: current_user.id, likeable_type: "Post", likeable_id: params[:post_id])
    if @like.save!
      flash[:success] = "You've liked the post!"
      redirect_to :back
    else
      flash.now[:danger] = "Could not like that post"
      render :back
    end
  end



 
end
