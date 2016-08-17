class StaticPagesController < ApplicationController
  before_action :require_account_owner, :only => [:about_edit]
  before_action :require_login, :only => [:timeline, :photos, :friends]

  def home
    @home = true
    @user = User.new
    @user.build_profile
  end

  def timeline
    page_owner
    get_user_and_profile
  end

  def friends
    page_owner    
  end

  def about
    get_user_and_profile
    @profile = page_owner.profile
    get_random_backup_user_and_profile
  end

  def photos
    page_owner
  end

  def about_edit
    page_owner
    get_user_and_profile
  end


end
