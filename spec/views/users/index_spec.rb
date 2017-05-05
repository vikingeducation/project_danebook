require 'rails_helper'

describe "users/index.html.erb" do
  let(:user){ create(:user, :with_profile) }
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
    it 'has form to create a new post'
    it 'shows friends\' posts'
    it 'has link to edit own profile'
  end
end
