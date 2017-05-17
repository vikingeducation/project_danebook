require 'rails_helper'

feature 'Timeline' do
  let(:user){ create(:user) }
  let(:other_user){ create(:user) }

  context 'own timeline' do
    before do
      visit root_path
      sign_in(user)
      visit user_timeline_path(user)
    end

    specify 'successfully add post through new post form' do
      # correct elements visible
      expect(page).to have_link('Edit Profile')
      expect(page).not_to have_button('Add as Friend')

      # post form visible
      expect(page).to have_field('post[content]')

      # add post
      fill_in 'post[content]', with: 'this is a post'

      #check to see post count goes up
      expect{ click_button('Post') }.to change(Post, :count).by(1)
    end

    specify 'cannot create empty post' do
      fill_in 'post[content]', with: ''
      click_button('Post')
      expect(page).to have_content("Content can't be blank")
    end

  end

  context "viewing other users' timelines" do
    before do
      visit root_path
      sign_in(user)
      visit user_timeline_path(other_user)
    end

    specify 'links to authorized ' do 
      expect(page).not_to have_link('Edit Profile')
      expect(page).not_to have_field('post[content]')
    end

    specify 'add friend button visible' do
      expect(page).to have_link('Add as Friend')
    end         
  end


end