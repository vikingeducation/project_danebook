class LikesController < ApplicationController

  include LikesHelper

  before_filter :store_referer, :only => [:create, :destroy]

  def create

    like = Like.new(whitelisted_like_params)
    
    if like.save
      flash[:success] = "Created like"
    else
      flash[:error] = "Failed to create like"
    end
    redirect_to referer
  end

  def destroy

    like = Like.find(params[:id])
    if like.destroy
      flash[:success] ="Successfully deleted like"
    else
      flash[:error] = "Didnt delete like"
    end
    
    redirect_to referer
  end

  private

    def whitelisted_like_params
      params.require(:like).permit(:user_id, :likeable_id, :likeable_type)
    end

    def store_referer
      session[:referer] = URI(request.referer).path
    end

    def referer
      session.delete(:referer)
    end
end
