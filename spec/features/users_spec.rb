require 'rails_helper'

feature 'User accounts' do

  let(:profile) { create(:profile) }
  let(:user) { profile.user }

  before do
    # go to the home page
    visit root_path
  end

  scenario "Create user" do
    within "#new_user" do
      fill_in "user_first_name", with: "Testy"
      fill_in "user_last_name", with: "McTestface"
      fill_in "user_email", with: "testy@testface.com"
      fill_in "user_password", with: "testing123"
      fill_in "user_password_confirmation", with: "testing123"
      select "1986", from: "user_profile_attributes_birthday_1i"
      select "June", from: "user_profile_attributes_birthday_2i"
      select "7", from: "user_profile_attributes_birthday_3i"
      choose "Other"
      click_button "Sign Up"
    end
    expect(page).to have_css(".alert.alert-success", text: "Welcome")
    expect(User.find_by_email('testy@testface.com').profile.birthday).to eq(Date.parse("Sat, 07 Jun 1986"))
  end

  scenario "Create post" do
    log_in(user)
    click_link "Timeline"
    fill_in "post_body", with: "Test post"
    expect{ click_button('Post') }.to change( Post, :count).by 1
  end

  scenario "Comment on post" do
    create_post_by(user)
    fill_in "comment_body", with: "First comment"
    expect{ find_button("Comment").click }.to change(Comment, :count).by 1
  end

  scenario "Delete a comment on a post" do
    comment_from(user)
    within(".comment") do
      expect { click_link "Delete" }.to change(Comment, :count).by(-1)
    end
  end

end
