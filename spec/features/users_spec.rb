require 'rails_helper'

feature 'sign in' do
  let(:user) { profile.user }
  let(:profile) { create(:profile) }

  context 'unauthenticated user' do

    scenario 'can create a profile' do
      expect{create_account}.to change(User, :count).by(1)
    end
  end

  context 'returning user' do
    scenario 'signing in brings a user to their timeline page' do
      sign_in(user)
      expect(current_path).to eq(user_timeline_path(user))
    end
  end

end
