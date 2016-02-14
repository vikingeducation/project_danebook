class LikesController < ApplicationController

  before_action :require_login
  before_action :require_object_owner
  

  def create
    @like = Like.new(whitelisted_params)
    if @like.save
      flash[:success] = "You like it!"
    else
      flash[:error] = "Whoops - you can't like it right now."
    end
    redirect_to :back
  end



  def destroy
    @like = Like.find(params[:id])
    if @like.destroy
      flash[:success] = "You don't like that anymore."
    else
      flash[:error] = "Unable to process - you still like it."
    end
    redirect_to :back
  end




  private
  def whitelisted_params
    params.require(:like).permit(:user_id, :likeable_id, :likeable_type)
  end


end
