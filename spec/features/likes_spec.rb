require 'rails_helper'

feature 'liking posts' do

  before do
    visit root_path
    user = create(:user)
    profile = create(:profile, user: user)
    login(user)
    user_2 = create(:user)
    profile_2 = create(:profile, user: user_2)
    post = create(:post, user: user_2)
    visit (user_posts_path(user_2))
  end

  scenario 'user likes a post' do
    expect{ click_link('Like') }.to change(Like, :count).from(0).to(1)
    expect(page).to have_content("You like this")
    expect(page).to have_content("Unlike")
    expect{ click_link('Unlike') }.to change(Like, :count).from(1).to(0)
  end

end