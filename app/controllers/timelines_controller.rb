class TimelinesController < ApplicationController

  def show
    if User.find_by_id(real_user_id) == nil
      flash[:danger] = "Sorry, that user does not exist. But if you sign up your friends, someday we'll get there!"
      redirect_to user_timeline_path(current_user)
    end
  end
end
