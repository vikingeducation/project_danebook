class FriendingsController < ApplicationController

  before_action :require_login

  def index
    user = User.find(params[:user_id])
    @friends = user.friends
  end

  def create
    friending_recipient = User.find(params[:friend_id])

    if current_user.friended_users << friending_recipient
      flash[:success] = "You friended #{friending_recipient.full_name}"
      redirect_to friending_recipient
    else
      flash[:error] = "Friending failure. Try again!"
      redirect_to friending_recipient
    end
  end

   def destroy
    #can also delete friending from friending join table directly
    #using association below
    unfriended_user = User.find(params[:friend_id])
    if current_user.friended_users.delete(unfriended_user)
      flash[:success] = "Unfriended #{unfriended_user.full_name}!"
      redirect_to current_user

    # #if friended by, still considered friend by button (not in db)
    # #can destroy friending even if someone else initiated it,
    # # as long as user current user is in the relationship
    # elsif current_user.users_friended_by.delete(unfriended_user)
    #   flash[:success] = "Unfriended #{unfriended_user.full_name}!"
    #   redirect_to current_user

    else
      flash[:error] = "Unfriending failure. Try again!"
      redirect_to unfriended_user #not unfriended yet
    end
  end

  private

  # def params_list
  #     params.require(:friending).permit(:id, :friend_id)
  # end


end
