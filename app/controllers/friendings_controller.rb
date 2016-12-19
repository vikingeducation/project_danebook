class FriendingsController < ApplicationController

  def index
    @user = User.find_by_id(params[:user_id])
    @friends = @user.friends
  end

  def create
    friending_recipient = User.find(params[:id])
    if current_user.friended_users << friending_recipient
      flash[:success] = "You friended #{friending_recipient.full_name}!"
      redirect_to friending_recipient
    else
      flash[:error] = "APES!!! IT DIDN'T WORK!!! WHY DIDN'T IT WORK???"
      redirect_to friending_recipient
    end
  end

  def destroy
    @unfriending_recipient = User.find(params[:id])
    @friending = current_user.initiated_friendings.where("friended_id = #{@unfriending_recipient.id}") || current_user.received_friendings.where("friender_id = #{@unfriending_recipient.id}").first
    if @friending.destroy_all
      flash[:success] = "Unfriended!"
      redirect_to @unfriending_recipient
    else
    end
  end

end
