class FriendingsController < ApplicationController

  def create
    recipient = User.find(params[:friending][:friender_id])
    @friending = current_user.friended_users.build(friending_params)
    if @friending.save
      flash[:success] = "You have created new friend"
      redirect_to :back
    else
      flash[:danger] = "Something went wrong! Couldn't make a new friend"
      redirect_to :back
    end
  end

  def destroy
    @friending = find_friending(friending_params, friending_params_inverse)
    if @friending.destroy
      flash[:success] = "You have lost a friend successfully!"
      redirect_to :back
    else
      flash.now[:danger] = "Loosing friend didn't work"
      redirect_to :back
    end
  end

  private
  def friending_params
    params.require(:friending).permit(:friend_id, :friender_id)
  end

  def friending_params_inverse
    params.require(:friending).permit(:friend_id, :friender_id)
    a = params[:friending][:friend_id]
    b = params[:friending][:friender_id]
    params[:friending][:friend_id] = b
    params[:friending][:friender_id] = a
  end

end
