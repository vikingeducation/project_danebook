class LikesController < ApplicationController

  


  def create
    @like = Like.new(user_id: current_user.id, likeable_type: Like.find_likable_type(request.original_fullpath), likeable_id: params[:post_id] || params[:comment_id])
    if @like.save!
      flash[:success] = "You've liked the post!"
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = "Could not like that post"
      render :back
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if current_user.id == @like.user_id && @like.destroy
      flash[:success] = "You've unliked the post!"
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = "Coult not unlike that post"
      render :back
    end
  end



 
end
