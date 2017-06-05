require 'rails_helper'

describe 'photos/index.html.erb' do
  let(:user){ create(:user, :with_profile) }
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
    it 'has button to upload photos if logged in' do
      render
      expect(view.content_for(:module_title)).to have_link('Add Photos')
    end
  end
  context 'logged out' do
    before do
      assign(:user, user)
      def view.current_user
        nil
      end
      def view.user_signed_in?
        false
      end
    end
    it 'does not have button to upload photos' do
      render
      expect(rendered).not_to have_link('Add Photos')
    end
  end
end
