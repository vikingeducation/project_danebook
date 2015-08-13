class LikesController < ApplicationController
  
   before_action :require_login
   
  def create
    like = Like.new(like_params_list)
    like.user_id = current_user.id
    if like.save
      redirect_to URI(request.referer).path and return
    else
      flash[:error] = "An error has occurred"
    end
    redirect_to URI(request.referer).path and return
  end

  def destroy
    like = Like.find(params[:id])
    
    if current_user.id == like.user_id 
      like.destroy
      redirect_to URI(request.referer).path and return
    else
      flash[:error] = "An error has occurred"
    end
    redirect_to URI(request.referer).path and return
  end

  private

  def like_params_list
      params.require(:like).permit(:duty_id , :duty_type, :user_id, :id)
  end

end
