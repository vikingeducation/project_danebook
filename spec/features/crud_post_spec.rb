require 'rails_helper'


feature 'Signed In User' do

  let(:user){ create(:user) }

  before do
    sign_in(user)
  end

  scenario 'sees a new post form on timeline page' do

    visit root_path
    expect(page).to have_css('textarea[placeholder="Tell the world something..."]')
  end

  scenario 'can create post and have it show up on timeline' do
    visit root_path
    fill_in "post_body", with: "This is a super cool post!"

    expect{click_button "Post"}.to change(Post, :count).by(1)

    expect(page).to have_content("This is a super cool post!")
    expect(page).to have_content("Posted on #{user.posts.last.created_at}")
  end

  context 'user already has a post' do

    before do
      user.posts = create_list(:post, 1)
      user.save
    end

    scenario 'can see their post when they visit their timeline' do
      visit user_posts_path(user.id)
      expect(page).to have_content("something in post body")
    end

    scenario 'cannot see their post without signing in' do
      sign_out
      visit user_posts_path(user.id)
      expect(page).to_not have_content("something in post body")
    end

    scenario 'can delete his/her own post' do
      visit root_path
      expect{click_link "Delete"}.to change(Post, :count).by(-1)
    end

    scenario "does not see a new post form on other user's timeline" do
      sign_out

      other_user = create(:user, email: "other@email.com")
      sign_in(other_user)

      visit user_profile_path(user.id)
      expect(page).to_not have_css('textarea[placeholder="Tell the world something..."]')
    end

  end


end