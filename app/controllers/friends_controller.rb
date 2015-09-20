class FriendsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @friends = @user.friends.includes(profile: :photo).paginate(:page => params[:page], :per_page => 12)
    respond_to :html, :js
  end

  def create
    session[:return_to] ||= request.referer
    @user = current_user
    @target = User.find(params[:id])
    @friend_request = @user.initiated_friendings.build(friend_id: @target.id)

    respond_to do |format|
      if @user != @target && @friend_request.save!
        format.html { redirect_to session.delete(:return_to), notice: "Friend request sent" }
        format.js { render :create, status: :created }
      else
        format.html { redirect_to session.delete(:return_to), notice: "Something went wrong with your friend request!" }
        format.js { render json: @friend_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    session[:return_to] ||= request.referer
    @user = current_user
    @target = User.find(params[:id])

    # to delete the users initiated friending with the target
    friending1 = Friending.where(friend_id: @target.id).find_by_friender_id(@user.id)
    # to prevent the target from showing up in friend requests
    friending2 = Friending.where(friender_id: @target.id).find_by_friend_id(@user.id)

    respond_to do |format|
      # Covers all cases, but needs refactoring
      if (friending1 || friending2) && (!friending1 || friending1.destroy) && (!friending2 || friending2.destroy)
        format.html { redirect_to session.delete(:return_to), notice: "User unfriended" }
        format.js
      end
    end
  end
end
