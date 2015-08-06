class LikesController < ApplicationController

  include LikesHelper

  def create

    like = Like.new(whitelisted_like_params)
    
    if like.save
      flash[:success] = "Created like"
    else
      flash[:error] = "Failed to create like"
    end
    
    if like.likeable_type == "Comment"
      redirect_to user_posts_path(like.likeable.commentable.user)
    else
      redirect_to user_posts_path(like.likeable.user)
    end
  end

  def destroy

    like = Like.find(params[:id])
    type = like.likeable_type
    if like.destroy
      flash[:success] ="Successfully deleted like"
    else
      flash[:error] = "Didnt delete like"
    end
    
    if type == "Comment"
      redirect_to user_posts_path(like.likeable.commentable.user)
    else
      redirect_to user_posts_path(like.likeable.user)
    end
  end

  private

    def whitelisted_like_params
      params.require(:like).permit(:user_id, :likeable_id, :likeable_type)
    end
end
