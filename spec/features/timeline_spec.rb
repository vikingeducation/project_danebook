require 'rails_helper'

feature "Posting on timeline" do
  let(:user) { create(:user) }
  let(:profile) { create(:profile, user: user) }

  before do 
    profile
    visit root_path
    sign_in(user)
  end

  scenario "make a post" do
    expect { make_post(user) }.to change { Post.count }.by(1)
    expect(page).to have_content("Great Post!")
  end

  scenario "delete a post" do
    make_post(user)
    within(".post-like-delete") do
      expect { click_link "Delete" }.to change { Post.count }.by(-1)
    end
    expect(page).to_not have_content("Great Post!")
  end

  scenario "like a post" do
    expect { like_post(user) }.to change { Like.count }.by(1)
    expect(page).to have_content("Unlike")
  end

  scenario "unlike a post" do
    like_post(user)
    within(".post-like-delete") do
      expect { click_link "Unlike" }.to change { Like.count }.by(-1)
    end
    expect(page).to have_content("Like")
  end

  scenario "comment on a post" do
    expect { make_comment(user) }.to change { Comment.count }.by(1)
    expect(page).to have_content("Nice Comment!")
  end

  scenario "delete a comment from the post" do
    make_comment(user)
    within("div.panel-footer") do
      expect { click_link "Delete" }.to change { Comment.count }.by(-1)
    end
    expect(page).to_not have_content("Nice Comment!")
  end

  scenario "like a comment" do
    make_comment(user)
    within("div.panel-footer") do
      expect { click_link "Delete" }.to change { Comment.count }.by(-1)
    end
    expect(page).to_not have_content("Nice Comment!")
  end

  scenario "edit profile page"
  scenario "add a friend"
  scenario "remove a friend"
end