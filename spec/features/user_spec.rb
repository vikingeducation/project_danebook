require 'rails_helper'

feature 'User timeline' do
  let(:profile) { create(:profile) }
  let(:user) { profile.user }
  before do
    visit(root_path)
    sign_in(user)
  end

  scenario 'As a logged in user, I can view the timeline' do
    expect(current_path).to eq(about_user_path(user))
    expect(page).to have_content "You've successfully signed in"
  end

  scenario 'As a logged in user, I should be able to create a post' do
    visit(timeline_user_path(user))
    within(".post-form") do
      fill_in 'post[text]', with: 'Sample Text'
      click_button "Post"
    end
    expect(current_path).to eq(timeline_user_path(user))
    expect(page).to have_content "Created new post!"
  end

  scenario 'As a logged in user, I should be able to like a post' do
    post = create(:post)
    visit(timeline_user_path(user))
    first(:link, "Like").click
    expect(current_path).to eq(timeline_user_path(user))
    expect(page).to have_content "1 people like this"
  end

  scenario 'As a logged in user, I should be able to comment on a post' do
    post = create(:post)
    visit(timeline_user_path(user))
    within('#new_comment') do
      fill_in 'comment[text]', :with => 'New Comment'
      click_button "Comment"
    end
    expect(current_path).to eq(timeline_user_path(user))
    expect(page).to have_content "Successfully commented on the post"
    expect(page).to have_content "New Comment"
  end

  scenario 'As a logged in user, I should be able to like a comment' do
    comment = create(:comment)
    visit(timeline_user_path(user))
    within('.comment') do
      first(:link, "Like").click
    end
    expect(current_path).to eq(timeline_user_path(user))
    expect(page).to have_content "Unlike 1 people like this"
  end

  scenario 'As a logged in user, I should be able to delete my post' do
    post = create(:post, user: user)
    visit(timeline_user_path(user))
    expect(page).to have_link "Delete"
    first(:link, "Delete").click
    expect(current_path).to eq(timeline_user_path(user))
    expect(page).to have_content "Post deleted!"
  end

  scenario 'As a logged in user, I should be not able to delete others post' do
    post = create(:post)
    visit(timeline_user_path(user))
    expect(current_path).to eq(timeline_user_path(user))
    expect(page).not_to have_link "Delete"
  end

  scenario 'As a logged in user, I should be not able to delete others comment' do
    comment = create(:comment)
    visit(timeline_user_path(user))
    expect(page).not_to have_link "Delete"
  end
end

feature 'User Profile' do
  let(:profile) { create(:profile) }
  let(:user) { profile.user }
  before do
    visit(root_path)
    sign_in(user)
  end
  scenario 'As a logged in user, I should be able to view anyones profile' do
    new_profile = create(:profile)
    visit(about_user_path(new_profile.user))
    expect(current_path).to eq(about_user_path(new_profile.user))
    expect(page).not_to have_link "Edit your profile"
  end
  scenario 'As a logged in user, I should be able to edit my profile' do
    visit(about_user_path(user))
    expect(current_path).to eq(about_user_path(user))
    expect(page).to have_link "Edit your profile"
    click_link "Edit your profile"
    expect(current_path).to eq(edit_profile_path(user.profile))
  end
  scenario 'As a logged in user, I should not be able to edit others profile' do
    new_profile = create(:profile)
    visit(edit_profile_path(new_profile.user))
    expect(current_path).to eq(timeline_user_path(user))
    expect(page).to have_content "Not authorized!"
  end
end

feature 'Unauthorized user' do
  let(:profile) { create(:profile) }
  let(:user) { profile.user }
  scenario 'As a logged out user, I should not be able to view the timeline' do
    visit timeline_user_path(user)
    expect(current_path).to eq(root_path)
    expect(page).to have_content "Not authorized, please sign in!"
  end
end