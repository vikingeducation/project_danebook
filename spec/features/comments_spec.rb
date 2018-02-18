require 'rails_helper'

feature 'Posting a comment' do

  let(:user){create(:user)}
  let(:profile){create(:profile, :user_id => user.id)}

  before do
    user
    profile
    sign_in(user)
    visit user_posts_path(user)
    click_link "Timeline"
  end

  scenario "Successfull posting" do
    have_created_post
    have_created_comment
    expect(page).to have_content "You have created new comment"
    expect(page).to have_css ('div.alert-success')
  end

  scenario "Unable to post an empty comment" do
    have_created_post
    fill_in('comment_body', :with => '')
    click_button "Comment"
    expect(page).to have_content "Something went wrong!"
    expect(page).to have_css ('div.alert-danger')
  end


end
