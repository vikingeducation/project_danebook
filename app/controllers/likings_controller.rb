class LikingsController < ApplicationController
  def create
    liking = Liking.new( :user_id => current_user.id,
                          :post_id => params[:post_id] )
    if liking.save
      flash[:success] = "Like"
    end
    redirect_to (:back)
  end

  def destroy
    liking = Liking.where( user_id: current_user.id,
                           post_id: params[:id] ).first
    if liking.destroy
      flash[:success] = "Unlike"
    end
    redirect_to (:back)
  end
end
