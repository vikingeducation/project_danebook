class ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:id])
    @posts   = Post.where(profile_id: @profile.id)
    # raise "#{@posts.count}"
  end

end
