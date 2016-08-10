class StaticPagesController < ApplicationController
  skip_before_action :require_login

  def home

    redirect_to user_timeline_path(current_user) if signed_in_user?
  end

end
