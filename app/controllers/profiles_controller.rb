class ProfilesController < ApplicationController

  include UserCheck

  before_action :set_user, except: [:show]
  before_action :correct_user, except: [:index, :show]
  before_action :set_s3_direct_post, only: [:edit, :update]

  def show
    set_user_full_profile
  end

  def edit
    p "building new bio" unless current_user.profile.bio
    current_user.profile.build_bio unless current_user.profile.bio
  end

  def update
    if @user.profile.update(whitelisted)
      set_profile_img if params[:profile][:profile_gallery_attributes][:images_attributes]["0"][:url]
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
      img = Image.where(url: params[:profile][:profile_gallery_attributes][:images_attributes]["0"][:url])[0]
      @user.profile.update_attribute(:img, img.id) if img && img.id
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{current_user.id}/images/#{SecureRandom.uuid}-${filename}", success_action_status: '201', acl: 'public-read')
    end
end
