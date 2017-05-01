require 'rails_helper'

describe 'posts/_info_box_friends.html.erb' do
  let(:user){ create(:user, :with_profile, :with_accepted_friend_request)}
  let(:friend){ create(:user, :with_profile)}
  before do
    user.reload
    render partial: 'posts/info_box_friends', locals: { user: user, friends: user.friendees}
  end
  it 'shows the correct number of friends' do
    create(:friendship, :accepted, friender_id: user.id)
    user.reload
    render partial: 'posts/info_box_friends', locals: { user: user, friends: user.friendees}
    expect(rendered).to have_content('Friends (2)')
  end
  it 'shows friends' do
    friends = user.friendees
    expect(rendered).to have_content(friends.first.full_name)
  end
end
