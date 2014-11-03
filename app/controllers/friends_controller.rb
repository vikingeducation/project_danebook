class FriendsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @friends = @user.friends.includes(:profile_photo).paginate(:page => params[:page], :per_page => 12)
  end

  def create
    session[:return_to] ||= request.referer
    @user = current_user
    @friend_request = @user.initiated_friendings.build(friend_id: params[:user_id].to_i)
    if @user.id != params[:user_id] && @friend_request.save!
      flash[:success] = "Friend request sent"
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "Something went wrong with your friend request!"
      redirect_to session.delete(:return_to)
    end
  end

  def destroy
    session[:return_to] ||= request.referer
    @user = current_user
    @target = params[:id]

    # to delete the users initiated friending with the target
    friending1 = Friending.where(friend_id: @target).find_by_friender_id(@user.id)
    # to prevent the target from showing up in friend requests
    friending2 = Friending.where(friender_id: @target).find_by_friend_id(@user.id)

    if friending1.destroy && (!friending2 || friending2.destroy)
      flash[:success] = "User unfriended"
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "Something when wrong when unfriending"
      redirect_to session.delete(:return_to)
    end
  end
end
