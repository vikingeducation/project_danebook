class FriendingsController < ApplicationController

  def create
    friending_recipient = User.find(params[:id])

    if current_user.friended_users << friending_recipient
      redirect_to user_posts_path(friending_recipient)
    else
      redirect_to friending_recipient
    end
  end

  def destroy
    user_to_unfriend = User.find(params[:id])
    current_user.friended_users.delete(user_to_unfriend)
    redirect_to current_user
  end

end
