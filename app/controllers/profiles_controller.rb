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
      if invalid_address
        flash[:danger] = "Invalid address."
        redirect_to edit_profile_path(@user.profile)
      else
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

    def invalid_address
      if hometown_attrs = profile_params[:hometown_attributes]
        hometown_attrs = hometown_attrs[:address_attributes].except(:id)
      end
      if residence_attrs = profile_params[:residence_attributes]
        residence_attrs = residence_attrs[:address_attributes].except(:id)
      end

      unless incomplete_address(hometown_attrs,residence_attrs)
        case
        when blank_address(hometown_attrs,residence_attrs),Geocoder.new(hometown_attrs).search,Geocoder.new(residence_attrs).search
          @profile.update(profile_params)
          return false
        end
      end

      true
    end

    def blank_address(hometown_attrs,residence_attrs)
      !residence_attrs && !hometown_attrs
    end

    def incomplete_address(home,residence)
      return true if home && home.values.any? { |v| v == '' }
      return true if residence && residence.values.any? { |v| v == '' }
    end

end
