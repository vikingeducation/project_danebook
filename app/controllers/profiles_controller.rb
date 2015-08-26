class ProfilesController < ApplicationController

  def index
    response = Profile.search(params[:search])
    @users = response.map { |profile| profile.user }
  end

end