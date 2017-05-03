require 'rails_helper'

describe 'photos/show.html.erb' do
  let(:user){ create(:user, :with_profile)}
  let(:friend){ create(:user, :with_profile)}
  let(:photo){ create(:photo, user: user)}
  let(:posting){ create(:post, user: user)}
  before do
    assign(:user, user)
    assign(:photo, photo)
    assign(:comment, photo.comments.build)
    def view.current_user
      nil
    end
    def view.user_signed_in?
      false
    end
  end
  it 'displays poster\'s name' do
    render
    expect(rendered).to have_link(user.full_name)
  end
  it 'does not show action buttons' do
    render
    expect(rendered).not_to have_link('Set as Profile')
    expect(rendered).not_to have_link('Set as Cover')
    expect(rendered).not_to have_link('Delete Photo')
  end
  context 'logged in and current user' do
    before do
      assign(:user, friend)
      assign(:current_user, user)
      def view.current_user
        @current_user
      end
      def view.user_signed_in?
        true
      end
    end
    it 'does not show action buttons on friend\'s photo page' do
      render
      expect(rendered).not_to have_link('Set as Profile')
      expect(rendered).not_to have_link('Set as Cover')
      expect(rendered).not_to have_link('Delete Photo')
    end
    it 'shows action buttons on own photo page' do
      assign(:user, user)
      render
      expect(rendered).to have_link('Set as Profile')
      expect(rendered).to have_link('Set as Cover')
      expect(rendered).to have_link('Delete Photo')
    end
  end
end
