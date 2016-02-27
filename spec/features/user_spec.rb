require 'rails_helper'

feature 'User' do
  
  #allow(book).to receive(:title).and_return("The RSpec Book")

#Happy

  context "Existing user navigation" do
    let(:user){create(:user)}
    let(:profile){create(:profile, :user_id => user.id)}
    before do
      sign_in(user)
    end
    scenario "can sign_in" do
      expect(page).to have_content "Sign Out"
      expect(page).to have_content "#{user.full_name}"
    end

    scenario "can sign_out" do
      sign_out(user)
      expect(page).to have_content "Signed out successfully"
      expect(page).to have_content "Connect with all your friends!"
    end
   
    scenario "redirected to About page" do
      expect(page).to have_content "About"
      expect(page).to have_content "About Me"
    end

    scenario  "can edit profile" do
      click_link "Edit Profile"
      expect(page).to have_content "Edit Your Profile"
    end

    scenario "can save changes in profile" do
      visit edit_user_profile_path(user.id)
      fill_in "Your college", with: "MIT"
      click_button "Save Changes"
      expect(page).to have_content "#{profile.college}"
    end


    context "interact with other's content" do
      let(:other_user){create(:user)}

      let!(:post){create(:post, :author => other_user)}
      scenario "can't delete other's post" do
        user_profile_path(other_user.id)
        expect(page).to have_content "#{other_user.full_name}"
        expect(page).not_to have_link('Delete') 
      end

      let!(:comment){create(:comment, :author => other_user)}
      scenario "can't delete other comment" do
        user_profile_path(other_user.id)
        expect(page).not_to have_link('Delete') 
      end

    end

  end

  #Happy
  context "Visitor" do

    scenario "can sign_up" do
      visit root_path
      fill_in "First Name", with: "Bot"
      fill_in "Last Name", with: "Big"
      fill_in "Your Email", with: "bb@gmail.com"
      fill_in "Your Password", with: "password"
      fill_in "Confirm Your Password", with: "password"
      click_button "Sign Up!"
      expect(page).to have_content "Bot Big"
      expect(page).to have_content "About"
    end

  end

end
