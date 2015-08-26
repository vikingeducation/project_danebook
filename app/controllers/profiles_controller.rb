class ProfilesController < ApplicationController

  def index
    @profiles = Profile.search(params[:search])
  end

end