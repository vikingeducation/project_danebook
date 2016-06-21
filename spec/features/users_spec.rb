require "rails_helper"

feature "User account" do 
  let(:user){ create(:user) }
  let!(:profile){ create(:profile, user: user )}

  before do
    visit root_path
  end

  context "Sign up" do

    scenario "sign up with valid attributes" do
      sign_up_user

      expect{ click_button "Sign Up !" }.to change(User, :count).by(1)

      expect(page). to have_content "User Created"
    end

    scenario 'sign up with invalid attributes' do
      sign_up_user(password_confirmation: "passwordxx")

      expect { click_button "Sign Up !" }.not_to change(User, :count)

      expect(page).to have_content 'Something went wrong'
    end
  end

  context "Sign in" do

    scenario "User can sign in with valid credential" do

      sign_in(user)

      expect(page).to have_content "Sign out"
    end

    scenario "User cannot log in with invalid credential" do
     
      user.password = "xxx"
      sign_in(user)

      expect(page).to have_content "Nope, it didn't work"
    end
  end

  context "Edit Profile" do

    scenario 'User can edit his own profile if sign up' do
      sign_in(user)

      click_on 'Edit your Profile'

      expect(current_path).to eq edit_user_path(user)

    end

    scenario "User cannot edit other user's profile" do
      another_user = create(:user)
      another_profile = create(:profile, user: another_user)

      sign_in(user)

      visit edit_user_path(another_user)

      expect(page).to have_content "Not Authorize"
    end

    scenario "Visitor cannot edit any user's profile" do
      visit edit_user_path(user)

      expect(page).to have_content "Not Authorize"
    end
  end

  context "Create Post" do
    scenario "User can create new post"

    scenario 'Visitor cannot create post'
  end

  context "Delete Post" do
    scenario "User can delete his own post"

    scenario "User cannot delete other people's post"

  end

  context "Create Comment" do
    scenario "User can create new comment"

    scenario 'Visitor cannot create comment'
  end

  context "Delete Comment" do
    scenario "User can delete his own comment"

    scenario "User cannot delete other people's comment"

  end
end