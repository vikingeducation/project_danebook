class TimelinesController < ApplicationController

  def index
    @timeline = Timeline.new(user_id: params[:user_id])
  end

end
