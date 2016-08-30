require 'rails_helper'

feature 'Timeline' do
  let!(:user) { create(:user) }

  before do
    visit root_path
  end

  context 'when the user is logged in' do

    before do
      # macro!!
      visit login_path
      form = find("div#login-form")
      form.fill_in 'session_email', with: user.email
      form.fill_in 'session_password', with: user.password
      form.click_button 'Submit'
    end

    context 'when the user is the correct user' do

      before do
        visit timeline_path(user.timeline)
      end

      it 'allows the user to view his own timeline' do
        expect(page).to have_content('Birthday')
        expect(page).to have_content('Photos')
        expect(page).to have_content('Post')
      end

      it 'allows the user to make a new post' do
        form = find("div#post-form")
        form.fill_in 'post_body', with: 'this is a new post!!!'
        form.click_button 'Post'
        expect(page).to have_content('You\'ve created a new post!')
      end

      it 'allows the user to make a new comment' do
        # Write a new post.
        post_form = find("div#post-form")
        post_form.fill_in 'post_body', with: 'this is a new post!!!'
        post_form.click_button 'Post'

        # Comment that post.
        comment_form = find("div#comment-form")
        comment_form.fill_in 'post_comments_attributes_0_body', with: 'this is a new comment!!!'
        comment_form.click_button 'Comment'
        expect(page).to have_content('Added a comment.')
      end

    end

    context 'when the user is not the correct user'
  end

end