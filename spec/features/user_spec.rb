require 'rails_helper'

feature "Visitors" do
  before do
    visit root_path
  end

  scenario "error message flashes for invalid signup information" do
    fill_sign_up_info
    fill_in "user[email]", with: ""
    expect { click_on "Sign up!" }.to change(User, :count).by(0)
    expect(current_path).to eql(root_path)
    expect(page).to have_css("div.alert-danger")
  end

  scenario "cannot visit any user pages" do
    user = create(:user)

    visit(user_path(user))
    expect(current_path).to eql(root_path)

    visit(about_user_path(user))
    expect(current_path).to eql(root_path)

    visit(edit_user_path(user))
    expect(current_path).to eql(root_path)

    visit(user_photos_path(user))
    expect(current_path).to eql(root_path)

    visit(user_friends_path(user))
    expect(current_path).to eql(root_path)
  end

  scenario "can login to account" do
    user = create(:user)

    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_on "Sign in"
    expect(current_path).to eql(user_path(user))
    expect(page).to have_content(user.name)
  end

  scenario "can sign up as a new user" do
    fill_sign_up_info
    expect { click_on "Sign up!" }.to change(User, :count).by(1)
    expect(page).to have_content("El Duderino")
  end

end

feature "Users" do
  let(:user) { create(:user) }
  let(:post_text) { "Can you believe it?!" }

  before do
    login(user)
  end

  scenario "returning signed-in users are taken from the root path to their timeline page"

  scenario "can visit another user's profile" do
    new_user = create(:user)
    visit(user_path(new_user))

    expect(page).to have_content(new_user.name)
  end

  scenario "no post form is available on another user's page" do
    user2 = create(:user)
    post2 = create_user_post(user2)
    post2_text = post2.text

    visit user_path(user2)
    expect(page).to_not have_content("Post!")
  end

  scenario "can edit the about information" do
    quote_text = "THE DUDE ABIDES!"

    visit edit_user_path(user)

    fill_in("user[quote]", with: quote_text)
    click_on("Update Profile")

    expect(current_path).to eql(about_user_path(user))
    expect(page).to have_content(quote_text)
  end

  scenario "can create a new post" do
    fill_in('post_text', with: post_text)

    expect{ click_button("Post!") }.to change(Post, :count).by(1)
    expect(page).to have_content(post_text)
  end

  context "User has a post" do
    let(:post) { create_user_post(user) }

    scenario "can delete a post" do
      post_text = post.text
      visit user_path(user)

      expect{ click_on("Delete Post") }.to change(Post, :count).by (-1)
      expect(page).to_not have_content(post_text)
    end

    scenario "can't delete another user's post" do
      user2 = create(:user)
      post2 = create_user_post(user2)
      post2_text = post2.text

      visit user_path(user2)

      expect(page).to have_content(post2_text)
      expect(page).to_not have_content("Delete Post")
    end

    scenario "can like and unlike a post" do
      post.text
      visit user_path(user)

      expect { click_on("Like") }.to change(Like, :count).by(1)
      expect { click_on("Unlike") }.to change(Like, :count).by(-1)
    end

    scenario "can like another user's post" do
      user2 = create(:user)
      post2 = create_user_post(user2)
      post2_text = post2.text

      visit user_path(user2)
      expect { click_on("Like") }.to change(Like, :count).by(1)
      expect(page).to have_content("Unlike")
    end

  end

  context "Comments" do
    let(:post) { create_user_post(user) }
    let(:comment) { create_post_comment(post) }
    before do
      visit user_path(user)
    end

    scenario "can like a comment" do
      #TODO
      comment
      within ".comment" do
        expect { click_on("Like") }.to change(Like, :count).by(1)
      end
    end

    scenario "can unlike a comment"

    scenario "can comment on another user's post"

    scenario "can delete a comment"

  end

  scenario "can sign out of account"

end
