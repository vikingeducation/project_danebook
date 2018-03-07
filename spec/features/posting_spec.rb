require 'rails_helper'

RSpec.feature 'Posting', type: :feature do
  let(:user){ create(:user) }
  before do
    visit root_path
  end

  context "A visitor" do
    scenario 'can not make a new post' do
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

      scenario 'can post on my own timeline' do
        post_body = 'This is a sample post'
        fill_in('post[body]', with: post_body)
        within('div.post-form') do
          click_button('Post')
        end
        expect(page).to have_content(post_body)
      end

      scenario 'can see my posts on my own timeline' do
        post_1 = create(:post, user_id: user.id, body: 'post 1')
        post_2 = create(:post, user_id: user.id, body: 'post 2')
        visit user_timeline_path(user)
        expect(page).to have_content(post_1.body)
        expect(page).to have_content(post_2.body)
      end

      scenario 'can delete a post from my own timeline' do
        post_1 = create(:post, user_id: user.id, body: 'post 1')
        visit user_timeline_path(user)
        click_link('Delete Post')
        expect(page).to_not have_content("posts/#{post_1.id}")
      end

      scenario "see only posts by me on my own timeline" do
        user_2 = create(:user)
        user_2_post = create(:post, user_id: user_2.id, body: 'user_2 post')
        visit user_timeline_path(user)
        expect(page).to_not have_content(user_2_post.body)
      end

      scenario "other people can't delete my posts"
    end #Timeline

    context 'on their Feed' do
      before do
        visit user_feed_path(user)
      end

      scenario 'can post on my own feed' do
        post_body = 'This is a sample post'
        fill_in('post[body]', with: post_body)
        within('div.post-form') do
          click_button('Post')
        end
        expect(page).to have_content(post_body)
      end

      scenario 'can see my posts on my own feed' do
        post_1 = create(:post, user_id: user.id, body: 'post 1')
        post_2 = create(:post, user_id: user.id, body: 'post 2')
        visit user_feed_path(user)
        expect(page).to have_content(post_1.body)
        expect(page).to have_content(post_2.body)
      end

      scenario 'can delete a post from my own feed' do
        post_1 = create(:post, user_id: user.id, body: 'post 1')
        visit user_feed_path(user)
        click_link('Delete Post')
        expect(page).to_not have_content("posts/#{post_1.id}")
      end

      scenario "can see my friends' posts in my feed" do
        user_2 = create(:user)
        user_2_post = create(:post, user_id: user_2.id, body: "user_2's post")
        create(:friending, recipient_id: user_2.id, initiator_id: user.id)

        visit user_feed_path(user)
        expect(page).to have_content(user_2_post.body)
      end
    end #Feed

  end #signed-in user

end #Timeline
