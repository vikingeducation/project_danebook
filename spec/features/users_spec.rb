require 'rails_helper'

feature 'Basic User Actions' do
  def sign_in(user)
    visit root_path
    fill_in 'nav email', with: user.email
    fill_in 'nav password', with: user.password
    click_button 'Log In'
  end
  let(:user){ build(:user)}
  scenario "logs in a user" do
    sign_in user
    expect(page).to have_content('Words to live by')
  end
end