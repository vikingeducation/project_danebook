require 'rails_helper'
require 'pry'

describe 'ProfilesRequest' do
  let(:user){ create(:user, :with_profile) }
  let(:profile_atts){ attributes_for(:profile, id: user.profile.id, quote: 'This is a quote')}
  context 'logged_in' do
    before do
      login_as(user, scope: :user)
    end
    describe 'PATCH #update' do
      it 'can update' do

        # patch user_path(user), params: {user: attributes_for(:user, profile_attributes: profile_atts) }
        patch user_path(user), params: {user: attributes_for(:user, profile_attributes: attributes_for(:profile, id: user.profile.id, quote: 'This is a quote'))}
        user.reload

        expect(user.profile.quote).to eq('This is a quote')
      end
    end
  end
end
