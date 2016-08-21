class ProfilesController < ApplicationController

  skip_before_action :correct_user
  before_action :correct_profile

  def edit
    @profile = current_user.profile
    @user = current_user
    @cities = City.all
    @states = State.all
    @countries = Country.all
  end

  def update
    @profile = current_user.profile
    @user = current_user
    if photo_id = profile_params[:cover_photo]
      @profile.update(profile_params.except(:cover_photo))
      photo = Photo.find(photo_id)
      @profile.update(cover_photo: photo)
    else
      @profile.update(profile_params)
    end
    flash[:success] = "Profile updated."
    redirect_to @user
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
            :city_id,
            :state_id,
            :country_id
          ] }
        ] },
        { residence_attributes: [
          :id,
          { address_attributes: [
            :id,
            :city_id,
            :state_id,
            :country_id
          ] }
        ] },
        { contact_info_attributes: [:email, :phone] })
    end

end
