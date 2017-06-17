require "rails_helper"

def fill_sign_up_form(params)
  fill_in "user_profile_attributes_first_name", with: params[:first_name]
  fill_in "user_profile_attributes_last_name", with: params[:last_name]
  fill_in "user_email", with: params[:email]
  fill_in "user_password", with: params[:password]
  fill_in "user_password_confirmation", with: params[:password_confirmation]
  fill_in "user_profile_attributes_birthday", with: params[:birthday]
  click_button "Sign up"
end

def fill_sign_in_form(params)
  fill_in "Email", with: params[:email]
  fill_in "Password", with: params[:password]
  click_button "Log in"
end

def fill_post_form(params)
  fill_in "post_body", with: params[:body]
  click_button "Post"
end

feature "User events" do
  before do
    visit root_path
  end
  let(:user) do
    user = create(:user)
    create(:profile, user: user)
    user
  end
  let(:post_){ create(:post_, user: user)}

  context "as a visitor" do
    before{ user }

    scenario "sign up" do
      fill_sign_up_form(attributes_for(:user).merge(attributes_for(:profile, user: nil)))
      expect(page).to have_content "User created successfully"
    end

    scenario "failed to sign up" do
      fill_sign_up_form({})
      expect(page).to have_content "Failed to create user"
    end

    scenario "sign in" do
      fill_sign_in_form(email: user.email, password: user.password)
      expect(page).to have_content "Signed in successfully"
    end

    scenario "failed to sign in" do
      fill_sign_in_form({})
      expect(page).to have_content "Failed to log in"
    end
  end

  context "as a signed-in user" do
    before do
      [user, post_]
      visit root_path
      fill_sign_in_form(email: user.email, password: user.password)
    end

    scenario "view timeline" do
      expect(page).to have_content post_.body
    end

    scenario "view my profile" do
      click_link "About"
      expect(page).to have_content "Basic Information"
    end

    scenario "post a post" do
      post_to_be = attributes_for(:post_, user: nil)
      fill_post_form(post_to_be)
      expect(page).to have_content "Post created successfully"
      expect(page).to have_content post_to_be[:body]
    end

    scenario "fail to post a post" do
      fill_post_form({})
      expect(page).to have_content "Failed to create post"
    end
  end
end
