require 'rails_helper'

feature 'Like Features' do

  let(:profile){ create(:profile, :with_attributes ) }
  let(:post){ create(:post) }
  let(:user){ create(:user, profile: profile, posts: [post]) }
  
  
  before do
    sign_in(user)
    click_link "Timeline"
  end

  scenario "like a post creates new like" do
    expect{click_link "Like"}.to change(Like, :count).by(1)
    expect(page).to have_content("Like added.")
    expect(page).to have_content("likes this")
  end

  scenario "unlike a post removes like" do
    click_link "Like"
    expect{click_link "Unlike"}.to change(Like, :count).by(-1)
    expect(page).to have_content("Unliked")
  end

end