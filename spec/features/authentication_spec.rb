require 'rails_helper'

feature 'authentication' do

  let(:existing_user){ create(:user) }
  let(:new_user){ build(:user) }
  
  before do
    visit root_path
  end

  context 'when signing in' do
    scenario 'errors if incorrect params' do
      sign_in(new_user)
      expect(current_path).to eq(root_path)
    end

    scenario 'log in successfully' do
      sign_in(existing_user)
      expect(current_path).to eq(user_timeline_path(existing_user))
    end

    scenario 'errors if log in form fields empty' do
      click_button('Log In')
      expect(page).to have_content("We couldn't sign you in!")
    end
  end

  context 'when signing up' do
    scenario 'cannot access timeline/about pages yet' do
      visit(about_user_path(existing_user))
      expect(current_path).to eq(login_path)
    end

    scenario 'creates new user when sign up successful' do
      expect{ sign_up(new_user) }.to change(User, :count).by(1)
    end

    scenario 'displays errors when sign up unsuccessful' do
      unsuccessful_new_user = build(:user, :first_name => '')
      sign_up(unsuccessful_new_user)
      expect(page).to have_content('Sign Up')
    end

    scenario 'existing user cannot sign up' do
      sign_up(existing_user)
      expect(page).to have_content('Email has already been taken')
    end
  end

end