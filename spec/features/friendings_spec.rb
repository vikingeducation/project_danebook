require 'rails_helper'

feature 'Create Friendship' do

  let(:user){ create(:user) }
  
  # profile user is the future user we want to friend
  let(:profile){create(:profile)}
  
  before do
    sign_in(user)
  end

  context 'no previous Friendship when visiting user2' do
    before do
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
      #creates two friendships 
      #user is now friends with whomever the user asked
      #The friend is now friends with the user
      #Thus two new friendships
      expect{ click_link("Friend")}.to change(Friend, :count).by(2)
    end

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
      expect{ click_link("Unfriend") }.to change(Friend, :count).by(-1)

    end

    context 'there is previous friendship' do
      before do
        Friend.create(:user_id => user.id, :friend_id=>profile.user.id)
        visit user_posts_path(profile.user)

      end

      it 'should list other user as friend in friends list' do
        visit user_posts_path(user)
        click_link("Friends")
        expect(page).to have_content(profile.user.full_name)
      end

      it 'should list the user in the new friends friend list' do
        click_link("Friends")
        expect(page).to have_content(user.full_name)
      end

      context 'user unfriends the other user(profile.user)' do
        before do
          click_link("Unfriend")
          
        end

        it 'should not list the profile(user) in users friend list' do
          click_link("Friends")
          expect(page).to_not have_content(profile.user.full_name)
        end


        it 'should not list the user in profile users friend list' do
          visit user_posts_path(profile.user)
          click_link("Friends")
          within(:xpath, "/html/body/main/div/div[2]") do
            expect(page).to_not have_content(user.full_name)
          end
        end
      end   
    end
  end
end









