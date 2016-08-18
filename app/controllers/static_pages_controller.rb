class StaticPagesController < ApplicationController
  before_action :require_account_owner, :only => [:about_edit]
  before_action :require_login, :only => [:timeline, :photos, :friends]

  def home
    @home = true
    @user = User.new
    @user.build_profile
  end

  def timeline
    set_instance_variables
  end

  def friends
    set_instance_variables
        
  end

  def about
    set_instance_variables
    @profile = @page_owner.profile
  end

  def photos
    set_instance_variables
  end

  def about_edit
    set_instance_variables
  end


end
