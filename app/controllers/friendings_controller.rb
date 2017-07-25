class FriendingsController < ApplicationController

  def create
    @friending = current_user.friendings.build(friending_params)
    if @friending.save
      flash[:success] = "You have created new friending"
      redirect_to user_timeline_path(@friending.user_id)
    else
      flash[:danger] = "Something went wrong! No friendings created!"
      redirect_to user_timeline_path(@friending.user_id)
    end
  end

  def destroy
    @friending = Like.all.where(friending_params)[0]
    if @friending.destroy
      flash[:success] = "You have unfriendingd successfully!"
      redirect_to user_timeline_path(current_user.id)
    else
      flash.now[:danger] = "Unliking didn't work :("
      redirect_to :back
    end
  end

  private
  def friending_params
    params.require(:friending).permit(:friendingable_id, :friendingable_type)
  end

end
