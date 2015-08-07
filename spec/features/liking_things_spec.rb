require 'rails_helper'

feature 'Like a post' do

  let(:user){create(:user)}
  let(:other_user){create(:user)}

  before do
    user.posts = create_list(:post, 1)
    sign_in(other_user)
  end

  #signed in as other_user
  scenario "users can 'like' a post" do
    visit user_posts_path(user.id)

    click_link 'Like'
    expect(page).to have_content(user.birthdate)
    expect(page).to have_content("You like this.")
  end

  scenario "user can 'unlike' something they liked already" do
    visit user_posts_path(user.id)
    click_link 'Like'

    expect(find_link('Unlike').visible?).to be true

    click_link 'Unlike'
    expect(page).to_not have_content("You like this.")
  end

  scenario "user can 'like' a comment"


end