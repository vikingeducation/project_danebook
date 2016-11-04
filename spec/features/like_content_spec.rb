require 'rails_helper'

feature 'Like functionality' do
  let(:user) { create(:user) }
  let(:profile) { create(:profile, user: user) }
  let(:comment) { create(:comment, post: post, user: user) }
  let(:post) { create(:post, user: user) }
  let(:otheruser) { create(:user) }

  before do
    profile
    post
    login(user)
  end

  scenario 'I would like to like one of my own posts' do
    visit user_timeline_path(user)
    expect { click_link('Like') }.to change { post.likes.count }.by(1)
  end

  scenario "I would like to like someone else's post" do
    otheruser.profile = create(:profile)
    otheruser.posts << create(:post)
    visit user_timeline_path(otheruser)
    click_link('Like')
    expect(page).to have_link('Unlike')
  end

  scenario 'I would like to like a comment' do
    comment
    visit user_timeline_path(user)
    within('.comment') do
      click_link('Like')
    end
    expect(page).to have_link('Unlike')
  end
end
