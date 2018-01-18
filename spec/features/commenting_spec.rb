require 'rails_helper'

RSpec.feature 'Commenting', type: :feature do
  let(:user){ create(:user) }
  before do
    visit root_path
  end

  context "A visitor" do

    xscenario 'can not make a new comment' do
      visit new_user_post_path(user)
      expect(current_path).to eq(login_path)
    end
  end #visitors

  context 'As a signed-in user' do
    before do
      login(user)
    end

    context 'on their Timeline' do
      before do
        visit user_timeline_path(user)
      end

      scenario "can comment on their timeline post" do
        write_post
        comment_body = 'sample comment'
        fill_in('comment[body]', match: :first, with: comment_body)
        click_button('Comment')
        expect(page).to have_content(comment_body)
      end

      scenario "can delete their comment from their timeline post" do
        write_post
        comment_body = 'sample comment'
        fill_in('comment[body]', match: :first, with: comment_body)
        click_button('Comment')
        comment = Comment.last
        click_link('Delete Comment')
        expect(page).to_not have_content("comments/#{comment.id}")
      end

    end #Timeline

    context 'on their Feed' do
      before do
        visit user_feed_path(user)
      end
    end #Feed

  end #signed-in user

end #Timeline
