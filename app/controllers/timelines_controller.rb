class TimelinesController < ApplicationController

  before_action :require_login, :except => [:show ]

  def show
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @post = Post.new
  end

  private
    def whitelisted_params
      params.require(:profile).permit( :motto, :college, :residing, :phone, :hometown, :about,
                                     :gender,
                                     :first_name,
                                     :last_name)
    end

end
