class FeedsController < ApplicationController

  def show
    @feed = Feed.new(user_id: params[:user_id])
  end

end
