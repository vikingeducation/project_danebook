require 'rails_helper'


feature 'visitors' do

  let(:user) { build(:user) }


  scenario "cannot access profile" do
    user.save
    visit user_profile_path(user)

    expect(page).to have_content('Error! Not authorized, please sign in!')
  end


end