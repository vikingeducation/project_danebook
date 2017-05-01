require 'rails_helper'

describe 'shared/_profile_header.html.erb' do
  let(:user){ create(:profile).user }

  before do
    def view.current_user
      nil
    end
    def view.user_signed_in?
      false
    end
    assign(:user, user)
  end
  it 'shows the user\'s name' do
    render
    expect(render).to have_content(user.full_name)
  end
  it 'shows button do add friend' do
    render
    expect(render).to have_content('Add Friend')
  end
  it 'has links to user\'s other pages' do
    render
    expect(rendered).to match(user_profile_path(user))
    expect(rendered).to match(user_about_path(user))
    expect(rendered).to match(user_photos_path(user))
    expect(rendered).to match(user_friends_path(user))
  end

  context 'logged in' do
    let(:friend){ create(:user, :with_profile)}
    let(:user){ create(:user, :with_profile)}
    let(:request_received){ create(:friendship, friender_id: friend.id, friendee_id: user.id )}
    let(:request_sent){ create(:friendship, :pending, friender_id: user.id, friendee_id: friend.id) }
    before do
      assign(:user, friend)
      @current_user = user
      def view.current_user
        @current_user
      end
      def view.user_signed_in?
        true
      end
    end
    it 'shows button to add friend' do
      render
      expect(rendered).to have_content('Add Friend')
    end
    it 'shows button to remove friend if friends' do
      create(:friendship, :accepted, friender_id: user.id, friendee_id: friend.id)
      render
      expect(rendered).to have_content('Remove Friend')
    end
    it 'shows button to cancel friend request if one has been sent' do
      request_sent
      render
      expect(rendered).to have_content('Cancel Request')
    end
    it 'shows button to accept request if one has been received' do
      request_received
      render
      expect(rendered).to have_content('Accept Request')
    end
    it 'does not show friend action button if on own page' do
      def view.current_user
        @user
      end
      render
      expect(rendered).not_to have_content('Add Friend')
      expect(rendered).not_to have_content('Remove Friend')
      expect(rendered).not_to have_content('Cancel Request')
    end
  end

end
