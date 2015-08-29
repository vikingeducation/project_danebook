require 'rails_helper'


feature 'Create new User' do

  let(:new_user) { build(:user, :profile => build(:base_profile)) }

  before do
    visit root_path
  end


  scenario 'with valid attributes' do
    fill_out_new_user_form(new_user)

    click_button 'Sign Up!'

    expect(page).to have_content 'Thank you for signing up!'
    expect(page).to have_content 'Log Out'
    expect(page.current_path).to eq(user_posts_path(User.last))
  end


  scenario 'with invalid attributes' do
    fill_out_new_user_form(new_user)
    fill_in 'user_profile_attributes_first_name', with: ""

    click_button 'Sign Up!'

    expect(page).to have_content 'Sign up failed'
    expect(page).to have_content "First Name can't be blank"
    expect(page.current_path).to eq(users_path)
  end


  scenario 'if user email is already in use' do
    existing_user = create(:user)

    fill_out_new_user_form(new_user)
    fill_in 'user[email]', with: existing_user.email

    click_button 'Sign Up!'

    expect(page).to have_content 'Sign up failed'
    expect(page).to have_content "Email has already been taken"
    expect(page.current_path).to eq(users_path)
  end

end