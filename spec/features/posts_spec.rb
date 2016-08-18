require 'rails_helper'

feature 'Creating New Post' do

  let(:profile) {create(:profile)}
  let(:other_profile) {create(:profile)}
  let(:user){ create(:user, profile: profile)}
  let(:other_user){ create(:user, :email => "foo2@email.com", profile: profile)}

  before do
    visit root_path
    sign_in(user)
  end

  scenario "creating a post" do 
    fill_in "post[body]", with: "Post body"
    expect{ click_button "Post!" }.to change(Post, :count).by(1)
    expect(page).to have_css(".alert-success")

  end

  scenario "can't create an empty post" do 

    fill_in "post[body]", with: ""
    expect{ click_button "Post!" }.to change(Post, :count).by(0)
    expect(page).to have_css(".alert-danger")

  end

  scenario "deleting a post you wrote" do

    fill_in "post[body]", with: "Post body"
    click_button "Post!"
    expect{ click_link "Delete Post"}.to change(Post, :count).by(-1)
    expect(page).to have_css(".alert-success")

  end




end




















