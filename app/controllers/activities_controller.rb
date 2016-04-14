class ActivitiesController < ApplicationController
  layout 'newsfeed'

  before_action :require_login


  def index
    @activities = Post.newsfeed(current_user)
    @new_post = Post.new(user_id: current_user.id)
  end


end
