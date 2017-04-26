require 'rails_helper'

describe 'shared/_nav_bar.html.erb' do
  let(:user){ create(:profile).user }
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
      expect(rendered).to have_content(user.first_name)
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
