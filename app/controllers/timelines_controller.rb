class TimelinesController < ApplicationController

  before_action :require_login, :except => [:show ]

  def show
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @post = Post.new
    @post.user_id = current_user.id
  end


  #
  # def whitelisted_params
  #   params.require(:user).permit(:email,
  #                                :password,
  #                                :password_confirmation,
  #                                { profile_attributes: [:birthday,
  #                                  :gender,
  #                                  :first_name,
  #                                  :last_name]}
  #                                )
  # end


end
