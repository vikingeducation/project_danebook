class FriendingsController < ApplicationController

  before_action :require_login
  before_action :redirect_if_not_found

  def create
    friending = Friending.new(target: @recipient,
                              friender: current_user)
    if friending.save
      flash[:success] = "Successfully friended #{@recipient.name}"
      redirect_to @recipient # user show page
    else
      flash[:alert] = "You're already friends with this person!"
      redirect_to ref
    end
  end

  def destroy
    friending = Friending.find_by(friender: current_user,
                                  target: @recipient)
    if friending
      friending.destroy
      # current_user.friends.delete(@recipient)
      flash[:success] = "Successfully unfriended #{@recipient.name}"
    else
      flash[:alert] = "You already unfriended this person!"
    end
    redirect_to ref
  end

  private

  def redirect_if_not_found
    @recipient = User.find_by(id: params[:user_id])
    unless @recipient
      flash[:error] = "User was not found!"
      redirect_to ref
    end
  end

end
