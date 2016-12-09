class ProfilesController < ApplicationController

  include UserCheck

  before_action :set_user, except: [:show]
  before_action :correct_user, except: [:index, :show]

  def show
    set_user_full_profile
  end

  def edit
    p current_user.profile.build_bio unless current_user.profile.bio
  end

  def update
    if @user.profile.update(whitelisted)
      @user.profile.update_attribute(:edited, true)
      flash[:success] = ["Profile Successfully Edited"]
      redirect_to user_profile_path(@user)
    else
      flash.now[:danger] = ["Something went wrong.."]
      @user.profile.errors.full_messages.each do |error|
        flash.now[:danger] << error
      end
      render :edit
    end
  end

  private
    def whitelisted
      params.require(:profile).permit(:birthday, :college, :hometown, :current_home, :phone,
                                      {bio_attributes: [
                                        :slogan,
                                        :about
                                      ]})
    end
end
