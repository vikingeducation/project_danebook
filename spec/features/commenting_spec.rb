require 'rails_helper'

RSpec.feature 'Commenting', type: :feature do
  let(:user){ create(:user) }
  before do
    visit root_path
  end

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

      scenario "can comment on their own feed post" do
        write_post
        comment_body = 'sample comment'
        fill_in('comment[body]', match: :first, with: comment_body)
        click_button('Comment')
        expect(page).to have_content(comment_body)
      end

      scenario "can delete their comment from their feed post" do
        write_post
        comment_body = 'sample comment'
        fill_in('comment[body]', match: :first, with: comment_body)
        click_button('Comment')
        comment = Comment.last
        click_link('Delete Comment')
        expect(page).to_not have_content("comments/#{comment.id}")
      end

      scenario "can comment on their friend's feed post" do
        user_2 = create(:user)
        user_2_post = create(:post, user_id: user_2.id, body: "user_2's post")
        create(:friending, recipient_id: user_2.id, initiator_id: user.id)
        visit user_feed_path(user)

        comment_body = 'sample comment'
        fill_in('comment[body]', match: :first, with: comment_body)
        click_button('Comment')
        expect(page).to have_content(comment_body)
      end

      scenario "can delete their comment from their friend's feed post" do
        user_2 = create(:user)
        user_2_post = create(:post, user_id: user_2.id, body: "user_2's post")
        create(:friending, recipient_id: user_2.id, initiator_id: user.id)
        visit user_feed_path(user)

        comment_body = 'sample comment'
        fill_in('comment[body]', match: :first, with: comment_body)
        click_button('Comment')

        comment = Comment.last
        click_link('Delete Comment')
        expect(page).to_not have_content("comments/#{comment.id}")
      end
    end #Feed

  end #signed-in user

end #Timeline
