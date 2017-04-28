class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.initiated_friendships.build(friendee_id: params[:user_id])
    @recipient = User.find(params[:user_id])
    if @friendship.save
      flash[:success] = "Your request to add #{@recipient.full_name} as a friend has been sent"
    else
      flash[:error] = "Sorry, but you can't send a friend invite to #{@recipient.full_name}"
    end
    redirect_to user_profile_path(@recipient)
  end

  def update
  end

  def destroy
    @friendships = current_user.initiated_friendships(params[:user_id].to_i)
    @friend = User.find(params[:user_id])
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

end
