class FriendingsController < ApplicationController
  def create
    @friend = User.find(params[:friend_id])
    current_user.friends << @friend

    if current_user.save!
      flash[:success] = "You have a new friend. Don't blow it"
      redirect_to @user
    else
      flash[:error] = "That friending wasn't successful. Perhaps its a sign"
      redirect_to @friend
    end
  end

  def destroy
    @friend = User.find(params[:friend_id])
    current_user.friends.delete(@friend)

    if current_user.save!
      flash[:success] = "Bye Bye #{friend.first_name} #{friend.last_name}"
      redirect_to @friend
    else
      flash[:error] = "We couldn't defriend you...perhaps its a sign"
      redirect_to @friend
    end
  end
end