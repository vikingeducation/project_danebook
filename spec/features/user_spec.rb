require 'rails_helper'

feature 'User' do
  let(:user){create(:user)}
  let(:profile){create(:profile, :user_id => user.id)}
  #allow(book).to receive(:title).and_return("The RSpec Book")
  before do
    
  end

  scenario "can sign_up" do

  end

  scenario "see has page" do
    allow(:current_user).to receive(:id).and_return(user.id)
 
    visit user_profile_path(user.id)
    save_and_open_page
    # binding.pry
   
    expect(page).to have_content "Email"


  end
end
