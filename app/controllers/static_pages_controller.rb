class StaticPagesController < ApplicationController
  before_action :require_account_owner, :only => [:about_edit]
  before_action :require_login, :only => [:timeline, :photos, :friends]

  def home
    @home = true
  end

  def timeline
    @user = current_user
    @profile = Profile.find_by_user_id(@user.id)
  end

  def friends
    
  end

  def about
    @user = current_user
    @profile = Profile.find_by_user_id(@user.id) if @user
    # pull a random one 
    @profile ||= Profile.all.sample
    @user ||= @profile.user
  end

  def photos
    
  end

  def about_edit
    
  end
end
