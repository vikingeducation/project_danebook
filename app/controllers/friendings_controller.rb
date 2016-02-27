class FriendingsController < ApplicationController
  
  before_filter :store_referer

  def create
    @user = User.find(params[:format])
    
    if Friending.create(user_id: current_user.id, friend_id: @user.id)
      flash[:success]="You friended #{@user.full_name}"
    else
      flash[:failure]="No friendship yet"
    end
    redirect_to referer
  end

  def destroy
    @user = User.find(params[:format])
    @profile = Profile.find_by_user_id(@user)
    friendship=Friending.where(:user_id => current_user.id, :friend_id => @user.id)
    if friendship.first.destroy
      flash[:success]="You unfriended #{@user.full_name}"
    else
      flash[:failure]="Still friends"
    end
    redirect_to user_friends_path(current_user)

  end

end
