require 'rails_helper'

describe "users/show.html.erb" do
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
    it 'can see button to edit profile' do
      render
      expect(view.content_for(:module_title)).to have_text('Edit Your Profile')
    end
    it 'cannot see button to edit profile if is not current user' do
      @not_current = create(:user, :with_profile)
      @user = create(:user, :with_profile)
      def view.current_user
        @not_current
      end
      assign(:user, create(:user, :with_profile))
      render
      expect(view.content_for(:module_title)).not_to have_text('Edit Your Profile')
    end
  end
  context 'logged out' do
    before do
      assign(:user, user)
      def view.user_signed_in?
        false
      end
      def view.current_user
        nil
      end
    end
    it 'can\'t see button to edit profile' do
      render
      expect(view.content_for(:module_title)).not_to have_text('Edit Your Profile')
    end
  end
end
