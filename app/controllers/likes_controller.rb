class LikesController < ApplicationController
  def create
    # so they can go back thence they came
    session[:return_to] ||= request.referer
    # use the params to find the appropriate model and object
    @class = params[:likable].capitalize.constantize
    @likable = @class.find(parent_id)
    # prepare the like with the current user's id
    @like = @likable.likes.build(user_id: current_user.id)
    if @like.save
      flash[:success] = "#{params[:likable].capitalize} liked"
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "An error occurred while liking"
      redirect_to session.delete(:return_to)
    end
  end

  def destroy
  end

  private

  def parent_id
    params[:post_id]
  end
end
