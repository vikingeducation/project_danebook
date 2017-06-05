require 'rails_helper'

describe 'shared/_nav_bar.html.erb' do
  let(:user){ create(:user, :with_profile)}
  let(:friend){ create(:user, :with_profile)}
  let(:request_received){ create(:friendship, friender_id: friend.id, friendee_id: user.id)}
  context 'logged in' do
    before do
      assign(:user, user)
      def view.user_signed_in?
        true
      end
      def view.current_user
        @user
      end
    end
    it 'shows user\'s first name' do
      render
      expect(rendered).to have_link(user.first_name)
    end
    it 'shows accept and reject options if friend requuest received' do
      request_received
      render
      expect(rendered).to have_link(user.first_name)
      expect(rendered).to have_link('Accept')
      expect(rendered).to have_link('Reject')
    end
  end
  context 'logged out' do
    before do
      def view.user_signed_in?
        false
      end
    end
    it 'shows login form ' do
      assign(:user, user)
      render
      expect(rendered).to have_button('Sign in')
    end
  end

end
