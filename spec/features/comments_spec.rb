require 'rails_helper'

feature 'Posting a comment' do

  let(:user){create(:user)}
  let(:profile){create(:profile, :user_id => user.id)}

  before do
    user
    profile
    visit root_path
    sign_in(user)
    click_link "Timeline"
  end

  scenario "Successfull posting" do
    fill_in('post_body', :with => 'Hey, This is my new post!!!')
    click_button "Post"
    fill_in('comment_body', :with => 'Hey, This is my new comment!!!')
    save_and_open_page
    click_button "Comment"
    expect(page).to have_content "You have created new comment"
    expect(page).to have_css ('div.alert-success')
  end

  scenario "Unable to post an empty comment" do
    fill_in('post_body', :with => 'Hey, This is my new post!!!')
    click_button "Post"
    fill_in('comment_body', :with => '')
    click_button "Comment"
    expect(page).to have_content "Something went wrong!"
    expect(page).to have_css ('div.alert-danger')
  end


end
