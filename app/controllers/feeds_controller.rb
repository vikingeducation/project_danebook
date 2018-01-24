class FeedsController < ApplicationController

  before_action :require_current_user

  def show
    @feed = Feed.new(user_id: params[:user_id])
    @photo = params[:photo]
  end

end
