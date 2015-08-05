class FriendingsController < ApplicationController

  def create
    friending_recipient = User.find(params[:id])

    if current_user.friended_users << friending_recipient
      flash[:success] = "Successfully friended #{friending_recipient.name}"
      redirect_to friending_recipient # user show page
    else
      flash[:alert] = "You're already friends with this person!"
      redirect_to friending_recipient
    end
  end

  def destroy
    unfriended_user = User.find(params[:id])

    # Locate the friendship we want to destroy BUT
    # ONLY within our current_user's friendships 
    # because otherwise it's a big security hole where
    # you could delete other people's friendships!
    # As above, you could do this multiple ways including
    # by directly locating the join table record and
    # destroying that.
    # In this case, we'll use the association `delete`
    # method to de-associate these Users.
    # No orphans were created in the making of this action :)
    current_user.friended_users.delete(unfriended_user)
    flash[:success] = "Successfully unfriended"
    redirect_to current_user
  end

end
