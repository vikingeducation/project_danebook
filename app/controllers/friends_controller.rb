class FriendsController < ApplicationController

  include UserCheck
  before_action :set_user_basic_profile

  def show
    @friends = @user.friends
  end

  def create
    @status, @msg = Friendify.friendship(current_user, @user)
    respond_to do |format|
      format.js { render template: 'shared/flashes' }
      format.html do
        flash[@status] = @msg
        redirect_to user_profile_path(@user.profile)
      end
    end
  end

  def destroy
    Friendify.clear_friendship(@user, current_user)

    redirect_to root_path
  end

end
