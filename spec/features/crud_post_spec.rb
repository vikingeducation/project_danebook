require 'rails_helper'

feature 'Create Post' do

  let(:user){ create(:user) }
  let(:post){ build(:post) }
  before do
    sign_in(user)
    visit user_posts_path(user)
  end

  context 'User can post on their own profile' do

    scenario 'User can create post if there is text in post form' do
      fill_in "post_body", with: "Test post body text"
      expect{click_button "Post"}.to change(Post, :count).by(1)
      expect(page).to have_content("Posted new story!")
    end

    scenario 'User stays on their own timeline after posting' do
      click_button "Post"
      expect(page).to have_content("#{user.first_name}")
      expect(page).to have_content("Post (copied)")
    end

    scenario "User can't post if there is no body" do
      fill_in "post_body", with: " "
      expect{click_button "Post"}.to change(Post, :count).by(0)
      expect(page).to have_content("Your post didn't post, bro")
    end

  end
end

feature 'Delete Post' do
  let(:user){ create(:user) }
  let(:post){ build(:post) }
  before do
    sign_in(user)
    visit user_posts_path(user)
  end

  context 'User can delete post on their own profile' do
    before do
      fill_in "post_body", with: "Test post body text"
      click_button "Post"
    end

    scenario 'Delete button exists on their post' do
      expect(page).to have_content("Delete")
    end

    scenario 'Delete button deletes post' do
      click_link "Delete"
      expect(page).to_not have_content("Test post body text")
    end

    scenario 'Deleting post keeps user on same page(their timeline)' do
      click_link "Delete"
      expect(page).to have_selector('form#new_post')
    end
  end
end

feature "Constraints on Another Users Page" do
  let(:user){ create(:user) }
  let(:post){ build(:post) }
  before do
    sign_in(user)
    visit user_posts_path(user)
  end

  context 'There are constraints when visiting another User\'s page' do
    
    let(:new_user){ (create(:user, :first_name => "new_foo"))}
    let(:new_post){ (create(:post, :body =>"new test"))}
    before do 
      visit user_posts_path(new_user)
    end

    scenario 'User can not delete post on another user\'s page' do
      expect(page).to_not have_content("Delete")
    end

    scenario 'User can not post on another user\'s page' do
      expect(page).to_not have_selector('form#new_post')
    end

  end




end

