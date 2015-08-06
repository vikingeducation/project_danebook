class FriendingsController < ApplicationController

  def create
    friending = Friending.new(friend_id: params[:friend_id], 
      friender_id: params[:friender_id])
    friending.save
    redirect_to users_profiles_path(params[:friend_id])
  end

  def index
    @friends << current_user.friended_users
    @friends << current_user.users_friended_by 
  end

end
