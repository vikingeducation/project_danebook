require 'rails_helper'

feature 'Post Features' do

  let(:profile){ create(:profile, :with_attributes ) }
  let(:user){ create(:user, :profile => profile) }
  
  before do
    sign_in(user)
    visit user_timeline_path(user)
  end

  scenario "submitting a new post creates a post" do
    fill_in "Tell the world something", with: "This is a test post."
    expect{click_button "Submit"}.to change(Post, :count).by(1)
    expect(page).to have_content("Post created")
    expect(page).to have_content("This is a test post.")
  end

  scenario "submitting blank post does not create new post" do
    expect{click_button "Submit"}.to change(Post, :count).by(0)
  end

  scenario "deleting a post removes the post" do
    fill_in "Tell the world something", with: "This is a test post."
    click_button "Submit"
    expect{click_link "Delete"}.to change(Post, :count).by(-1)
    expect(page).to have_content("Post deleted")
    expect(page).to_not have_content("This is a test post.")
  end

end