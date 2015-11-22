class LikesController < ApplicationController
  before_action :require_current_user, :only => [:create, :destroy]
  before_action :require_current_user_is_like_user, :only => [:destroy]

  def create
    @like = Like.new(like_params)
    if @like.save
      flash[:success] = 'Like created'
    else
      flash[:error] = 'Like not created: ' +
        @like.errors.full_messages.join(', ')
    end
    redirect_to request.referer
  end

  def destroy
    if @like.destroy
      flash[:success] = 'Like destroyed'
    else
      flash[:error] = 'Like not destroyed: ' +
        @like.errors.full_messages.join(', ')
    end
    redirect_to request.referer
  end


  private
  def like_params
    filtered_params = params.permit(
        :likeable_id,
        :likeable_type
      )
    filtered_params[:user_id] = current_user.id
    filtered_params
  end

  def require_current_user_is_like_user
    @like = current_user.likes.find(params[:id])
    unless @like
      flash[:error] = 'You are unauthorized to perform that action'
      redirect_to root_path
    end
  end
end
