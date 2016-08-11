class FriendsController < ApplicationController
  def index
    @friends = current_user.friends.paginate(page: params[:page])
    render 'static_pages/about', 
           locals: { user: current_user, 
                     microposts: nil, 
                     profile: current_user.profile, 
                     cities: nil, 
                     states: nil, 
                     countries: nil }, 
           action: :index
  end

  def create
    current_user.friends << User.find(friend_params[:user_id])
    flash[:success] = "You've added a friend!"
    redirect_to current_user
  end

  private

    def friend_params
      params.require(:friend).permit(:user_id)
    end
end
