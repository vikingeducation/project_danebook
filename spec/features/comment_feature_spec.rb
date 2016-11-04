require 'rails_helper'

feature 'Comment functionality' do
  let(:user) { create(:user) }
  let(:profile) { create(:profile, user: user) }
  let(:post) { create(:post, user: user) }
  let(:otheruser) { create(:user) }
  let(:otherprofile) { create(:profile, user: otheruser) }
  let(:otherpost) { create(:post, user: otheruser) }

  before do
    profile
    post
    otherprofile
    otherpost
    login(user)
  end

  scenario 'I would like to comment on a post' do
    visit user_timeline_path(user)
    fill_in('comment_comment_text', with: 'thisismytestcomment')
    click_button('Comment')
    expect(page).to have_content('thisismytestcomment')
  end

end
