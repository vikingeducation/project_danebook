require 'rails_helper'

describe 'NewsfeedRequests' do
  let(:user){ create(:user, :with_profile, :with_friends)}
  describe 'GET #index' do
    context 'logged out' do
      it 'redirects to sign in page' do
        get newsfeed_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
  context 'logged in' do
    before do
      login_as(user, scope: :user)
    end
    it 'loads the newsfeed page' do
      get newsfeed_path
      expect(response).to be_success
    end
  end

end
