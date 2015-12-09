class ActivitiesController < ApplicationController
  before_action :require_login

  def index
    @activities = Activity.feed_for(current_user).take(100)
  end
end
