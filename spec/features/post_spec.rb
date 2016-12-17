require 'rails_helper'

feature 'User posts, comments, and likes' do

  let(:profile1) { create(:profile) }
  let(:user1) { profile1.user }
  let(:profile2) { create(:profile) }
  let(:user2) { profile2.user }
  let(:profile3) { create(:profile) }
  let(:user3) { profile3.user }

  before do
    # go to the home page
    visit root_path
  end

  scenario "Create post" do
    log_in(user1)
    click_link "Timeline"
    fill_in "post_body", with: "Test post"
    expect{ click_button('Post') }.to change( Post, :count).by 1
  end

  scenario "Delete post" do
    create_post_by(user1)
    click_link "Delete"
    expect(page).to have_content "This user has no posts"
  end

  scenario "Comment on post" do
    create_post_by(user1)
    fill_in "comment_body", with: "First comment"
    expect{ find_button("Comment").click }.to change(Comment, :count).by 1
  end

  scenario "Delete a comment on a post" do
    comment_from(user1)
    within(".comment") do
      expect { click_link "Delete" }.to change(Comment, :count).by(-1)
    end
  end

  scenario "Comment on another's post" do
    crosscomment(user1, user2)
    expect(page).to have_content "#{user1.name} commenting on #{user2.name}'s post"
  end

  scenario "Like another's comment" do
    crosscomment(user1, user2)
    within(".comment") { click_link "Like" }
    expect(page).to have_content "#{user1.name} likes"
  end

  scenario "Unlike another's comment" do
    crosscomment(user1, user2)
    within(".comment") { click_link "Like" }
    within(".comment") { click_link "Unlike" }
    expect(page).not_to have_content "#{user1.name} likes"
  end

end
