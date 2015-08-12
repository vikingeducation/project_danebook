require 'rails_helper'

feature 'Create Friendship' do

  let(:user){ create(:user) }
  # let(:user2){ create(:user) }
  let(:profile){create(:profile)}
  
  before do
    sign_in(user)
  end

  context 'no previous Friendship when visiting user2' do
    before do
      # visit user_posts_path(user2)
      visit user_posts_path(profile.user)
    end

    it 'should  show a friend button on user 2 profile' do
      expect(page).to have_content("Friend")
    end

    it 'should not have an unfriend button' do
      expect(page).to_not have_content("Unfriend")
    end

    it 'should create a friendship when user clicks button' do
      Friend.new()
      # save_and_open_page
      expect{ click_button("Friend")}.to change(Friend, :count).by(1)
    end

    it 'shoud create friendship for both users'
  end

  context 'friendship already exists' do
    before do
      Friend.create(:user_id => user.id, :friend_id=>profile.user.id)
    end

    it 'should have an unfriend button' do
      visit user_posts_path(profile.user)
      expect(page).to have_content("Unfriend")
    end

    it 'removes friendship if unfriend button clicked' do
      visit user_posts_path(profile.user)
      save_and_open_page
      expect{ click_link("Unfriend") }.to change(Friend, :count).by(-1)

    end

    it 'should remvoe it for both users'

  end
end








