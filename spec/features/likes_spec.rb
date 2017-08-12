
require 'rails_helper'


feature 'Liking' do

  let(:user){create(:user)}
  let(:profile){create(:profile, :user_id => user.id)}

  before do
    user
    profile
    sign_in(user)
    visit user_posts_path(user)
    click_link "Timeline"
  end

  scenario "Able to like someone's comment" do
    have_created_post
    within("div.liked-box") do
      click_link 'Like'
    end
    expect(page).to have_content "Unlike"
    expect(page).to have_css ('div.alert-success')
  end

  scenario "Able to unlike already liked comment" do
    have_created_post
    have_created_comment
    within("div.like-area") do
      click_link 'Like'
    end
    click_link 'Unlike'
    expect(page).not_to have_content "Unlike"
    expect(page).to have_css ('div.alert-success')
  end


end
