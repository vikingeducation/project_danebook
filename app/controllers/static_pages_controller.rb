class StaticPagesController < ApplicationController
  before_action :require_account_owner, :only => [:about_edit]
  before_action :require_login, :only => [:timeline, :photos, :friends]

  def home
    @home = true
    @user = User.new
    @user.build_profile
  end

  def timeline
    get_user_and_profile
  end

  def friends
    
  end

  def about
    get_user_and_profile
    get_random_backup_user_and_profile
  end

  def photos
    
  end

  def about_edit
    get_user_and_profile
  end



  private

  def get_user_and_profile
    @user = current_user
    @profile = @user.profile if @user
  end

  def get_random_backup_user_and_profile
    @user ||= User.all.sample
    @profile ||= @user.profile
  end
end
