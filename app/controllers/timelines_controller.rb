class TimelinesController < ApplicationController

  def show
    @post = Post.new(:user_id => current_user.id)
  end
end
