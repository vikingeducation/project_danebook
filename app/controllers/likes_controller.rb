class LikesController < ApplicationController
  before_action :require_current_user, :only => [:create, :destroy]
  before_action :require_current_user_is_like_user, :only => [:destroy]

  def create
    @like = current_user.likes.build(like_params)
    if @like.save
      flash[:success] = 'Like created'
    else
      flash[:error] = 'Like not created: ' +
        @like.errors.full_messages.join(', ')
    end
    redirect_to_referer
  end

  def destroy
    if @like.destroy
      flash[:success] = 'Like destroyed'
    else
      flash[:error] = 'Like not destroyed: ' +
        @like.errors.full_messages.join(', ')
    end
    redirect_to_referer
  end


  private
  def like_params
    params.permit(
      :likeable_id,
      :likeable_type
    )
  end

  def require_current_user_is_like_user
    @like = current_user.likes.find_by_id(params[:id])
    unless @like
      flash[:error] = 'You are unauthorized to perform that action'
      redirect_to_referer
    end
  end
end
