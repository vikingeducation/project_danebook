class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.initiated_friendships.where(friendee_id: params[:user_id]).first_or_initialize
    @friendship.status = 'sent'
    @recipient = User.find(params[:user_id])
    if @friendship.save
      flash[:success] = "Your request to add #{@recipient.full_name} as a friend has been sent"
    else
      flash[:error] = "Sorry, but you can't send a friend invite to #{@recipient.full_name}"
    end
    redirect_to user_profile_path(@recipient)
  end

  def accept
    @friender = User.find(params[:id])
    @friendship = current_user.received_friendships.find_by(friender_id: @friender.id)
    if @friendship.update(accepted_params)
      flash[:success] = "You are now friends with #{@friender.full_name}"
    else
      flash[:error] = "Sorry, you couldn't accept the friend invite"
    end
    redirect_to user_profile_path(@friender)
  end

  def reject
    @friender = User.find(params[:id])
    @friendship = current_user.received_friendships.find_by(friender_id: @friender.id, friendee_id: current_user.id)
    if @friendship.update(status: 'rejected')
      flash[:success] = "You successfully rejected #{@friender.full_name}'s friend invitation"
    else
      flash[:error] = "Sorry, we couldn't reject the invite. It will just remain as 'pending'"
    end
    # this should not redirect to rejected friend path
    redirect_to user_profile_path(@friender)
  end

  def destroy
    @friend = User.find(params[:user_id])
    @friendships = current_user.initiated_friendships(friendee_id: @friend.id)
    if @friendships.destroy_all.blank?
      flash[:error] = "Looks like you're true BFFs"
    else
      flash[:success] = "You're no longer friends with #{@friend.first_name}"
    end
    redirect_to user_profile_path(@friend)
  end

  def index
    @user = User.find(params[:user_id])
    @friends = @user.friendees
  end

  def cancel
    @friendee = User.find(params[:id])
    @friendship = current_user.friendship_recipient(@friendee)
    if @friendship.destroy
      flash[:success] = "Your friendship request has been cancelled"
    else
      flash[:error] = "We couldn't cancel your friendship request"
    end
    redirect_to user_profile_path(@friendee)
  end

  private

  def accepted_params
    params.permit(:status).merge(friender_id: @friender.id)
  end



end
