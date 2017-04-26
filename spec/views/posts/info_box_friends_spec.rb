require 'rails_helper'

describe 'posts/_info_box_friends.html.erb' do
  let(:user){ create(:user, :with_profile)}
  before do
    user.friendees << create_list(:user, 2, :with_profile)
    user.reload
    render partial: 'posts/info_box_friends', locals: { user: user, friends: user.friendees}
  end
  it 'shows the correct number of friends' do
    expect(rendered).to have_content('Friends (2)')
  end
  it 'shows friends' do
    friends = user.friendees
    expect(rendered).to have_content(friends.first.full_name)
    expect(rendered).to have_content(friends.second.full_name)
  end
end
