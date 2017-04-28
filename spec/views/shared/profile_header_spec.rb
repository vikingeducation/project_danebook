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
  end
  it 'shows the user\'s name' do
    assign(:user, user)
    render
    expect(render).to have_content(user.full_name)
  end
  it 'shows button do add friend' do
    assign(:user, user)
    render
    expect(render).to have_content('Add Friend')
  end
  it 'has links to user\'s other pages' do
    assign(:user, user)
    render
    expect(rendered).to match(user_profile_path(user))
    expect(rendered).to match(user_about_path(user))
    expect(rendered).to match(user_photos_path(user))
    expect(rendered).to match(user_friends_path(user))
  end
  context 'logged in' do
    let(:friend){ create(:profile).user}
    let(:user){ create(:profile).user}
    before do
      assign(:user, user)
      @friend = friend
      def view.current_user
        @friend
      end
      def view.user_signed_in?
        true
      end
    end
    it 'shows button to add friend' do
      render
      expect(rendered).to have_content('Add Friend')
    end
    it 'shows button to delete friend' do
      friend.friendees << user
      render
      expect(rendered).to have_content('Remove Friend')
    end
  end

end
