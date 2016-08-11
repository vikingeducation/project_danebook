class ProfilesController < ApplicationController
  # before_action :to_integers

  def update
    profile = Profile.find(params[:id])
    profile.update(profile_params)
    redirect_to profile.user
  end

  private

    def profile_params
      params.require(:profile).permit(
        :id,
        { birthday_attributes: [
          :id,
          { profile_date_attributes: [
            :id,
            :month,
            :day,
            :year
          ] }
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
