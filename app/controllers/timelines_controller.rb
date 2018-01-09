class TimelinesController < ApplicationController

  def show
    @timeline = Timeline.new(user_id: params[:user_id])
  end

end
