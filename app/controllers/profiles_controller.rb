class ProfilesController < ApplicationController

  skip_before_action :correct_user
  before_action :correct_profile

  def edit
    @profile = current_user.profile
    @user = current_user
  end

  def update
    @profile = current_user.profile
    @user = current_user
    if photo_id = profile_params[:cover_photo]
      @profile.update(profile_params.except(:cover_photo))
      photo = Photo.find(photo_id)
      @profile.update(cover_photo: photo)
    else
      if check_address
        flash[:success] = "Profile updated."
        redirect_to @user
      end
    end
  end

  def change_cover
    render 'static_pages/change_cover'
  end

  private

    def profile_params
      params.require(:profile).permit(
        :words,
        :about,
        :cover,
        :cover_photo,
        { birthday_attributes: [
          :id,
          'date_object(2i)',
          'date_object(3i)',
          'date_object(1i)'
        ] },
        :college,
        { hometown_attributes: [
          :id,
          { address_attributes: [
            :id,
            :street_address,
            :city,
            :state,
            :zip_code,
            :country
          ] }
        ] },
        { residence_attributes: [
          :id,
          { address_attributes: [
            :id,
            :street_address,
            :city,
            :state,
            :zip_code,
            :country
          ] }
        ] },
        { contact_info_attributes: [:email, :phone] })
    end

    def check_address
      hometown_attributes = profile_params[:hometown_attributes][:address_attributes].except(:id)
      residence_attributes = profile_params[:residence_attributes][:address_attributes].except(:id)

      if !Geocoder.new(hometown_attributes).search
        flash[:danger] = "Invalid hometown address."
        redirect_to edit_profile_path(@user.profile)
      elsif !Geocoder.new(residence_attributes).search
        flash[:danger] = "Invalid residence address."
        redirect_to edit_profile_path(@user.profile)
      else
        @profile.update(profile_params)
        return true
      end

      false
    end

end
