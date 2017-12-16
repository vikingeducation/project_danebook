require 'rails_helper'

describe Post do
  let(:post){ build(:post) }

  it "is valid with default attributes" do
    expect(post).to be_valid
  end

  describe "Post Associations" do
     it "responds to the likes association" do
      expect(post).to respond_to(:likes)
    end
    it "responds to the comments association" do
      expect(post).to respond_to(:comments)
    end
  end
end

feature "Signed in User" do
  let(:user){create(:user)}
  let(:profile){ create(:profile,:user => user)}
  
  before do
    user
    profile
    visit root_path
    sign_in(user)
  end

  scenario "As a signed-in user, I want to create a post" do
    fill_in "post-text-area", with: "Test post"
    expect{ click_button "Post" }.to change(Post, :count).by(1)
    expect(page).to have_content "Test post"
    expect(page).to have_content "Created new post!"
  end

   scenario "As a signed-in user, I want to like a post" do
    fill_in "post-text-area", with: "Test post"
    click_button "Post"

    expect{ click_link "Like" }.to change(Like, :count).by(1)
    expect(page).to have_content "Liked the post!"
  end

  scenario "As a signed-in user, I want to unlike a post" do
    fill_in "post-text-area", with: "Test post"
    click_button "Post"
    click_link "Like"


    expect{ click_link "Unlike" }.to change(Like, :count).by(-1)
    expect(page).to have_content "Unliked item successfully."
  end
end
