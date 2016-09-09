require 'rails_helper'

feature 'Visitor Access' do
  let(:userb){ build(:user) }
  let(:userc){ create(:user) }
  let(:post){build(:post, :author => userc)}

  before do
    visit root_path
  end

feature 'visitor acccess' do
  scenario "sign up" do
    fill_in "First Name", with: userb.first_name
    fill_in "Last Name", with: userb.last_name
    fill_in "user[email]", with: userb.email
    fill_in "user[password]", with: userb.password
    fill_in "user[password_confirmation]", with: userb.password_confirmation
    choose('Male')
    select('Jan', :from => 'user[b_month]')
    select('1', :from => 'user[b_day]')
    select('1985', :from => 'user[b_year]')
    click_button "Sign Up!"
    expect(page).to have_content "User successfully created"
  end
end



end

feature 'member access' do

  let(:user){ create(:user) }
  let(:post){build(:post, :author => user)}
  let(:comment){build(:comment)}

  before do
    sign_in(user)
  end

  scenario 'sign in as a registered user' do
    sign_out
    sign_in(user)
    expect(page).to have_content "You've successfully signed in"
  end

  scenario 'as a signed-in user, I want to be able to create a post' do
    fill_in "Tell the world something...", with: post.body
    click_button 'Post'
    expect(page).to have_content "User succesfully updated"
  end

  scenario 'as a signed-in user, I want to be able to like a post' do
    post.save
    visit root_path
    click_link "Like"
    expect(page).to have_content "Like successfully created"
  end

  scenario 'as a signed-in user, I want to be able to unlike a post' do
    post.save
    visit root_path
    click_link "Like"
    click_link "Unlike"
    expect(page).to have_content "Your like has been deleted!"
  end

  scenario "as a signed in user, I want to be able to comment on a post" do
    post.save
    visit root_path
    fill_in "post[comments_attributes][0][body]", with: comment.body
    click_button "Comment"
    expect(page).to have_content "post succesfully updated"
  end

end
