class StaticPagesController < ApplicationController
  before_action :require_login, :only => [:timeline]
  before_action :set_user, :except => [:new, :create]

  def timeline
    @post = Post.new
    @posts = @user.recent_user_posts
    # fjdkfjd
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def whitelisted_user_params
      params.
        require(:user).
        permit( :first_name,
                :last_name,
                :email,
                :password,
                :password_confirmation,
                :birth_date)
    end

end
