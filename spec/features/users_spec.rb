require 'rails_helper'

feature 'User accounts' do
  before do 
    visit root_path
    user.profile = profile
    user.posts << post

  end

  let(:user)    { build(:user)} 
  let(:profile) { build(:profile)}
  let(:post)    {build(:post)}
  let(:liking)  {build(:liking)}

  context "as a visitor" do

    scenario "I want to sign up" do
      fill_sign_up(user)
  
      expect(page).to have_content('User was saved in database')
    end

    scenario "to sign in to my account" do
      user.save!
      fill_sign_in(user)
      
      expect(page).to have_content("You've successfully signed in")
    end
  end

  context "as a signed-in user" do
    before do
      user.save!
      fill_sign_in(user)
    end

    context "in terms of redirection" do

      scenario "clicking Danebook redirects me to my profile" do
        click_link(user.username)
        expect(page).to have_content("About(Text Area)")
      end

      scenario "clicking my name redirects me to my profile" do
        click_link(user.username)
        expect(page).to have_content("About(Text Area)")
      end

      scenario "logout of my account" do
        click_link("Logout")
        expect(page).to have_content("You've successfully signed out")
      end
    end

    context "in terms of posts" do
      before do
        visit root_path
      end

      scenario "create a post on my timeline" do
        fill_post(post)
        expect(page).to have_content("Post was created in User")
      end

      context "when a post exists" do
        before do
          fill_post(post)

        end

        scenario "delete a post on my timeline" do
          first(:link, "Destroy").click
          expect(page).to have_content("Post was deleted in User")
        end

        scenario "like a post on my timeline" do
          first(:link, "Like").click
          expect(page).to have_content("#{user.username} likes this..")
        end
      end

      context "when a post doesn't exist" do
      end
    end   
  end

end

