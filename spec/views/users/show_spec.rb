require 'rails_helper'

describe "users/show.html.erb" do
  let(:user){ create(:profile).user}
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
      expect(rendered).to have_text('Edit Your Profile')
    end
    it 'cannot see button to edit profile if is not current user' do
      @not_current = create(:profile).user
      @user = create(:profile).user
      def view.current_user
        @not_current
      end
      assign(:user, create(:profile).user)
      render
      expect(rendered).not_to have_text('Edit Your Profile')
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
      expect(rendered).not_to have_text('Edit Your Profile')
    end
  end
end
