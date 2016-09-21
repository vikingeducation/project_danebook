class FriendingsController < ApplicationController


  def create
    friending_recipient = User.find(params[:friended_id])

    if current_user.friended_users << friending_recipient && current_user != friending_recipient
      flash[:success] = "You've friended #{friending_recipient.profile.first_name}"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Could not friend #{friending_recipient.profile.first_name}"
      redirect_back(fallback_location: root_path)
    end
  end


  def destroy
    friending_recipient = User.find(params[:id])
    if current_user.friended_users.delete(friending_recipient)
      flash[:success] = "You've unfriended #{friending_recipient.profile.first_name}"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Could not unfriend #{friending_recipient.profile.first_name}"
      redirect_back(fallback_location: root_path)
    end
  end

  private


end
