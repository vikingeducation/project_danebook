class FriendsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @friends = @user.friends
  end

  def create
    session[:return_to] ||= request.referer
    @user = current_user
    @friend_request = @user.initiated_friendings.build(friend_id: params[:friend_id])
    if @friend_request.save!
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
    @target = params[:friend_id]
    friending1 = Friending.where(friend_id: @target).find_by_friender_id(@user.id)
    friending2 = Friending.where(friender_id: @target).find_by_friend_id(@user.id)
    if friending1.destroy && friending2.destroy
      flash[:success] = "User unfriended"
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "Something when wrong when unfriending"
      redirect_to session.delete(:return_to)
    end
  end
end
