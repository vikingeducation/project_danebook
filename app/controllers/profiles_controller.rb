class ProfilesController < ApplicationController

  include UserCheck

  before_action :set_user, except: [:show]
  before_action :correct_user, except: [:index, :show]

  def show
    set_user_full_profile
  end

  def edit
    current_user.profile.build_bio unless current_user.profile.bio
  end

  def update
    if @user.profile.update(whitelisted)
      @user.profile.update_attribute(:edited, true) unless @user.profile.edited
      flash[:success] = ["Profile Successfully Edited"]
      set_profile_img if params[:profile][:profile_gallery_attributes]
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
      params.require(:profile).permit(:user_id,
                                      :birthday,
                                      :college,
                                      :hometown,
                                      :current_home,
                                      :phone,
                                      { bio_attributes: [
                                                          :id,
                                                          :profile_id,
                                                          :slogan,
                                                          :about
                                                        ]
                                      },
                                      { profile_gallery_attributes: [
                                                                      :id,
                                                                      :user_id,
                                                                      { images_attributes: [
                                                                                              :id,
                                                                                              :gallery_id,
                                                                                              :url,
                                                                                              :description
                                                                                            ]
                                                                      }
                                                                    ]
                                      }
                                    )
    end

    def set_profile_img
      @rails =  Rails.application
      if params[:profile][:profile_gallery_attributes][:images_attributes]["0"][:url]
        flash[:success] << "Your image has been uploaded." << "Your image will be viewable after processing"
        @user.profile.fix_profile_image
      end
    end
end
