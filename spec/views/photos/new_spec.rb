require 'rails_helper'

describe 'photos/new.html.erb' do
  let(:user){ create(:user, :with_profile)}
  context 'logged in' do
    before do
      assign(:user, user)
      assign(:photo, Photo.new)
      def view.current_user
        @user
      end
      def view.user_signed_in?
        true
      end
    end
    it 'has button to add photo from web' do
      render
      expect(view.content_for(:module_body)).to match('Use Web Photo')
    end
    it 'has button to upload photo' do
      render
      expect(view.content_for(:module_body)).to match('Upload Photo')
    end
  end
end
