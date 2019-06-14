class TimelinesController < ApplicationController

  def show
    @timeline = Timeline.new(user_id: params[:user_id])
    @photo_post = params[:photo_post]
  end

end
