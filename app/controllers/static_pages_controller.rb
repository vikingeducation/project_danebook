class StaticPagesController < ApplicationController

  skip_before_action :logged_in_user
  skip_before_action :correct_user

  def home
  end
end
