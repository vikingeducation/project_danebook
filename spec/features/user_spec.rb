require 'rails_helper'

feature "Visitors" do

  let(:user) { build(:user) }

  before do
    create_dates
  end

  scenario "are automatically directed to sign_in page" do
    visit users_path

    expect(current_path).to eq(login_path)
  end

  scenario "can sign up" do
    sign_up(user)

    expect(page).to have_content(user.fullname)
    expect(current_path).to eq(user_activities_path(User.first))
  end

  scenario "redirected to signup on bad signup attempt" do
    bad_user = build(:user, email: "")
    sign_up(bad_user)

    expect(current_path).to eq(users_path)
  end

  scenario "can login" do
    user.save
    sign_in(user)

    expect(page).to have_content(user.fullname)
    expect(current_path).to eq(user_activities_path(user))
  end

  scenario "redirected to login on bad login attempt" do
    sign_in(user)

    expect(page).to have_content("Email and password do not match")
    expect(current_path).to eq(session_path)
  end

end

feature "Signed In Users" do

  let(:user) { create(:user) }
  let(:second_user) { create(:user) }
  let(:post_content) { "I am the man" }

  before do
    create_dates
    second_user.posts.create(content: "Hello")
    sign_in(user)
  end

  scenario "are automatically directed to activities page" do
    expect(current_path).to eq(user_activities_path(user))
  end

  scenario "can successfully sign out" do
    click_on "Signout"
    expect(current_path).to eq(root_path)
  end

  scenario "has the option to friend an unfriended user" do
    visit user_activities_path(second_user)

    expect(page).to have_content("Add Friend")
  end

  scenario "can successfully friend an unfriended user" do
    visit user_activities_path(second_user)

    expect { click_on "Add Friend" }.to change(user.followees, :count).by(1)
  end

  scenario "has the option to unfriend an friended user" do
    visit user_activities_path(second_user)
    click_on "Add Friend"

    expect(page).to have_content("Remove Friend")
  end

  scenario "can successfully friend an unfriended user" do
    visit user_activities_path(second_user)
    click_on "Add Friend"

    expect { click_on "Remove Friend" }.to change(user.followees, :count).by(-1)
  end

  scenario "cannot friend themselves" do
    expect(page).to_not have_content("Add Friend")
  end

  scenario "has the option to edit thier own page" do
    expect(page).to have_content("Edit Profile")
  end

  scenario "can successfully edit their own page" do
    click_on "Edit Profile"
    user_college = "App State"
    fill_in "user_college", with: user_college
    click_on "Save Changes"
    expect(page).to have_content(user_college)
  end

  scenario "does not have the option to edit another users page" do
    visit user_activities_path(second_user)

    expect(page).to_not have_content("Edit Profile")
  end

  scenario "has the option to post on their own page" do
    expect(page).to have_selector("input[value=Post]")
  end

  scenario "can successfully post on their own page" do
    create_post(user, post_content)

    expect { click_on "Post" }.to change(user.posts, :count).by(1)
    expect(page).to have_content(post_content)
  end

  scenario "can successfully delete post on their own page" do
    create_post(user, post_content)
    click_on "Post"

    expect { find("a[href=\"#{user_activity_path(user, user.activities.first)}\"]").click }.to change(user.posts, :count).by(-1)
    expect(page).to_not have_content(post_content)
  end

  scenario "Does not have the option to post on another users page" do
    visit user_activities_path(second_user)

    expect(page).to_not have_selector("input[value=Post]")
  end

  scenario "Can successfully comment on their own page" do
    create_post(user)
    click_on "Post"
    comment = "my comment"
    create_comment(comment)

    expect{ click_on "Post Comment" }.to change(user.comments_made, :count).by(1)
    expect(page).to have_content(comment)
  end

  scenario "Can successfully comment on another users page" do
    visit user_activities_path(second_user)
    comment = "my comment"
    create_comment(comment)

    expect{ click_on "Post Comment" }.to change(user.comments_made, :count).by(1)
    expect(page).to have_content(comment)
  end

  scenario "Can successfully delete their own comment on another users page" do
    visit user_activities_path(second_user)
    comment = "my comment"
    create_comment(comment)
    click_on "Post Comment"

    expect { find("a[href=\"#{user_activity_path(user, user.activities.first)}\"]").click }.to change(user.comments_made, :count).by(-1)
    expect(page).to_not have_content(comment)
    expect(current_path).to eq(user_activities_path(second_user))
  end

  scenario "Can successfully delete their own comment on their own page" do
    create_post(user)
    click_on "Post"
    comment = "my comment"
    create_comment(comment)
    click_on "Post Comment"

    expect { find("a[href=\"#{user_activity_path(user, user.activities.second)}\"]").click }.to change(user.comments_made, :count).by(-1)
    expect(page).to_not have_content(comment)
    expect(current_path).to eq(user_activities_path(user))
  end

  scenario "Can successfully like post on their own page" do
    create_post(user)
    click_on "Post"

    expect { find("a[href=\"#{activity_likings_path(user.activities.first)}\"]").click }.to change(user.liked_things, :count).by(1)
    expect(page).to have_content( "#{user.fullname} likes this" )
    expect(current_path).to eq(user_activities_path(user))
  end

  scenario "Can successfully unlike post on their own page" do
    create_post(user)
    click_on "Post"
    find("a[href=\"#{activity_likings_path(user.activities.first)}\"]").click

    expect { find("a[href=\"#{liking_path(user.liked_things.first)}\"]").click }.to change(user.liked_things, :count).by(-1)
    expect(page).to_not have_content( "#{user.fullname} likes this" )
    expect(current_path).to eq(user_activities_path(user))
  end

  scenario "Can successfully like post on another users page" do
    visit user_activities_path(second_user)

    expect { find("a[href=\"#{activity_likings_path(second_user.activities.first)}\"]").click }.to change(user.liked_things, :count).by(1)
    expect(page).to have_content( "#{user.fullname} likes this" )
    expect(current_path).to eq(user_activities_path(second_user))
  end

  scenario "Can successfully like comments on another users page" do
    visit user_activities_path(second_user)
    create_comment
    click_on "Post Comment"

    expect { find("a[href=\"#{activity_likings_path(user.activities.first)}\"]").click }.to change(user.liked_things, :count).by(1)
    expect(page).to have_content( "#{user.fullname} likes this" )
    expect(current_path).to eq(user_activities_path(second_user))
  end

  scenario "Can successfully unlike comments on another users page" do
    visit user_activities_path(second_user)
    create_comment
    click_on "Post Comment"
    find("a[href=\"#{activity_likings_path(user.activities.first)}\"]").click

    expect{ find("a[href=\"#{liking_path(user.liked_things.first)}\"]").click }.to change(user.liked_things, :count).by(-1)
    expect(page).to_not have_content( "#{user.fullname} likes this" )
    expect(current_path).to eq(user_activities_path(second_user))
  end

  scenario "Can successfully unlike posts on another users page" do
    visit user_activities_path(second_user)
    find("a[href=\"#{activity_likings_path(second_user.activities.first)}\"]").click

    expect{ find("a[href=\"#{liking_path(user.liked_things.first)}\"]").click }.to change(user.liked_things, :count).by(-1)
    expect(page).to_not have_content( "#{user.fullname} likes this" )
    expect(current_path).to eq(user_activities_path(second_user))
  end

  scenario "does not have the option to unlike another users like" do
    second_user.activities.first.likes.create(user_id: second_user.id)
    visit user_activities_path(second_user)

    expect(page).to_not have_content("Unlike")
  end

end
