class LikesController < ApplicationController
  #before_action :set_post_info, only: [:create, :destroy]
  before_action :require_login

  def create

    @like = Like.new(likeable_id: params[:likeable_id],
                     likeable_type: params[:likeable_type],
                      user_id: current_user.id )

    if @like.save
       flash[:success] = "Liked a #{params[:likeable_type]}!"
    else 
      flash[:alert] = "Cound not like the #{params[:likeable_type]}"
    end
    redirect_to user_posts_path(params[:user_id])

  end 

  def destroy

    @like = Like.find(params[:id])

    if @like.destroy
      flash[:success] = "Unliked the commented!"
    else
      flash[:alert] = "UnLike Failed!"
    end
  
    redirect_to user_posts_path(params[:user_id])
  end 


end
