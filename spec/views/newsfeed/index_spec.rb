require 'rails_helper'

describe 'newsfeed/index.html.erb' do
  let(:user){ build(:user, :with_profile, :with_friends)}
  context 'logged in' do
    before do
      assign(:user, user)
      def view.current_user
        @user
      end
      def view.user_signed_in?
        true
      end
    end
  end
end
