class UsersController < ApplicationController

  def index
  end

  def new
    @user = User.new
    @user.build_profile
  end

  private
    def whitelisted
      params.require(:user).permit(
                                    :email,
                                    :password,
                                    :password_confirmation,
                                    {
                                      profile_attributes:[
                                                          :first,
                                                          :last,
                                                          :birthday,
                                                          :gender
                                                        ]
                                    }
                                  )
    end
end
