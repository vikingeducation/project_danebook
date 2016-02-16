class LikesController < ApplicationController

  before_action :require_login

  def create

    @like = Like.new(likeable_id: params[:likeable_id],
                     likeable_type: params[:likeable_type],
                      user_id: current_user.id )

    if @like.save
       flash[:success] = "Liked a #{params[:likeable_type]}!"
    else 
      flash[:alert] = "Could not like the #{params[:likeable_type]}"
    end

    redirect_user_path(params[:user_id])

  end 

  def destroy

    @like = Like.find(params[:id])

    if @like.destroy
      flash[:success] = "Unliked!"
    else
      flash[:alert] = "UnLike Failed!"
    end

    redirect_user_path(params[:user_id])
  end 


  private
  def redirect_user_path(user_id)
    if user_id == current_user.id.to_s
      redirect_to new_user_post_path(user_id)
    else
      redirect_to user_posts_path(user_id)
    end 
  end

end
