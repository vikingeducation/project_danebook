require 'rails_helper'

feature 'friending' do
  
  let!(:user){ create(:user) }
  let!(:profile){ create(:profile, user:user) }
  let!(:user_2){ create(:user) }
  let!(:profile_2){ create(:profile, user: user_2) }
  
  before do
    visit root_path
    login(user)
  end

  scenario 'user on another user\'s about page' do
    visit(user_path(user_2))
    expect(page).to have_content("Friend #{user_2.profile.first_name}")
    expect{ click_link("Friend #{user_2.profile.first_name}") }.to change(Friending, :count).from(0).to(1)
    expect(page).to have_content("Unfriend #{user_2.profile.first_name}")
    expect{ click_link("Unfriend #{user_2.profile.first_name}") }.to change(Friending, :count).from(1).to(0)
  end

  scenario 'user on their own timeline' do
    visit(user_path(user_2))
    click_link("Friend #{user_2.profile.first_name}")
    visit(user_posts_path(user))
    expect(page).to have_content("Friends(1)")
    expect(page).to have_content("#{user_2.profile.full_name}")
  end

  scenario 'user on their own friends page' do
    visit(user_path(user_2))
    click_link("Friend #{user_2.profile.first_name}")
    visit(user_posts_path(user))
    click_link("Friends(1)")
    expect(page).to have_content("#{user_2.profile.full_name}")
  end

  scenario 'user has many friends' do
    users_to_friend = []
    7.times do 
      user = create(:user)
      create(:profile, user: user)
      users_to_friend << user
    end
    users_to_friend.each do |f|
      visit(user_path(f))
      click_link("Friend #{f.profile.first_name}")
    end
     visit(user_posts_path(user))
    # save_and_open_page
    # expect(page).to have_content("Friends(6)")
     click_link("Friends(7)")
     save_and_open_page  
  end
end