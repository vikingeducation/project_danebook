class LikingsController < ApplicationController

  def create
    @liking = @likeable.likings.new
    @liking.user_id = current_user.id
    if @liking.save
      flash[:success] = "Like"
    end
    redirect_to (:back)
  end

  def destroy
    @liking = @likeable.likings.where( user_id: current_user.id ).first
    if @liking.destroy
      flash[:success] = "Unlike"
    end
    redirect_to (:back)
  end
end
