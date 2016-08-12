class ProfilesController < ApplicationController
  before_action :require_login, :only => [:timeline]

  def show
    redirect_to timeline_user_profiles_path(current_user)
  end

  def timeline
    redirect_to about_user_profiles_path(current_user)

  end

  def friends
  end

  def about
    @profile = Profile.where('user_id': current_user.profile.user_id).first
  end

  def photos
  end
end
