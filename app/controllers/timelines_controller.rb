class TimelinesController < ApplicationController

  # Require login to see content about a user
  before_action :require_login, :only => [:show]
  # before_action :require_current_user, :only => [:show]

  def show
    @post = Post.new
  end

end
