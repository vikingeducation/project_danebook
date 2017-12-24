class FriendingsController < ApplicationController
  before_action :require_current_user => [:create, :destroy, :show]

  # def index
  #   @friends = Friending.all
  # end

  def show
    @friends = current_user.users_friended_by
  end

  def create
    friend_recipient = User.find(params[:id])
    # @friend = Friending.new(friending_params)
    if current_user.friended_users << friend_recipient
    # if @friend.save
      flash[:success] = "Added a friend!"
      # redirect_to edit_user_path(@user)
    else
      flash.now[:error] = "Failed to add a friend"
      # redirect_to root_path
    end
  end

  private

  def friending_params
    params.require(:friending).permit(:friend_id, :friender_id)
  end
end
