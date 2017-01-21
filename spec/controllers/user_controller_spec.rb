require 'rails_helper'

describe UsersController do

  context 'post#create' do

    context 'with correct input' do

      let(:valid_attributes) { attributes_for(:user, profile_attributes: attributes_for(:profile)) }

      it 'creates a new user' do
        expect{ sign_up(valid_attributes) }.to change(User, :count).by(1)
      end

      it 'redirects us to the user show page' do
        sign_up(valid_attributes)
        user = User.last
        expect(response).to redirect_to user_path(user)
      end

      it 'sets a success flash' do
        sign_up(valid_attributes)
        expect(flash[:success]).to be_present
      end

    end

    context 'with incorrect input' do

      let(:invalid_attributes) { attributes_for(:user, profile_attributes: attributes_for(:profile, birth_month: 13)) }

      it 'does not create a new user' do
        expect { sign_up(invalid_attributes) }.to change(User, :count).by(0)
      end

      it 'sets an error flash' do
        sign_up(invalid_attributes)
        expect(flash[:error]).to be_present
      end

    end

  end


  context 'patch#update' do

    let(:profile) { create(:profile) }
    let(:user) { profile.user }

    let(:other_profile) { create(:profile) }
    let(:other_user) { other_profile.user }

    let(:new_city) { 'Chicago' }

    before do
      log_in(user)
    end

    it 'updates a users\' profile' do
      update_user(user, profile, new_city)
      user.reload
      expect(user.profile.hometown).to eq(new_city)
    end

    it 'does not allow a user to update another users\' profile' do
      update_user(other_user, other_profile, new_city)
      other_user.reload
      expect(other_user.profile.hometown).to_not eq(new_city)
    end

  end

end