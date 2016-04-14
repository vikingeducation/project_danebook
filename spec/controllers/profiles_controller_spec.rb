require 'rails_helper'

describe ProfilesController do

  let(:profile) { create(:profile) }

  before do
    profile
    request.cookies[:auth_token] = profile.user.auth_token
    @request.env['HTTP_REFERER'] = root_path
  end


  describe 'PUT#update' do

    it 'sets success flash for valid params' do
      patch :update, user_id: profile.user.id, id: profile.id, profile: attributes_for(:profile)

      expect(flash["success"]).to_not be nil
    end

    it 'sets error flash for invalid params' do
      too_long = "Hometown"*9

      patch :update, user_id: profile.user.id, id: profile.id, profile: attributes_for(:profile, hometown: too_long)
      expect(flash["error"]).to_not be nil
    end

  end





end