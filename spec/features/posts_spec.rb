require 'rails_helper'
require 'pry'

feature 'Publish post' do

  let(:user){create(:user)}
  let(:profile){create(:profile, :user_id => user.id)}
  let(:user_two){create(:user)}
  let(:profile_two){create(:profile, :user_id => user_two.id)}

  before do
    user
    profile
    user_two
    profile_two
    sign_in(user)
    visit user_posts_path(user)
  end

  scenario "Successfll posting" do
    fill_in('post_body', :with => 'Hey, This is my new post!!!')
    click_button "Post"
    expect(page).to have_content "You have created new post"
    expect(page).to have_css ('div.alert-success')
  end

  scenario "Unable to post on other user's wall" do
    visit(user_timeline_path(user_two))
    save_and_open_page
    expect(page).not_to have_button('Post')
  end


end
