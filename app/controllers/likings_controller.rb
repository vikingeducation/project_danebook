class LikingsController < ApplicationController

  def create
    @activity = Activity.find(params[:activity_id])
    @activity.likes.create(user_id: current_user.id)
    respond_to do |format|
      format.html {redirect_to request.referer}
      format.js {  }
    end
  end

  def destroy
    @liking = Liking.find(params[:id])
    @user = @liking.user
    @activity = @liking.likeable
    if @user.id == current_user.id
      @liking.destroy
    else
      flash[:alert] = "You're not authorized to do this"
    end
    respond_to do |format|
      format.html {redirect_to request.referer}
      format.js {  }
    end
  end

end
