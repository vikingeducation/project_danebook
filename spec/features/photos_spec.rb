require 'rails_helper'

feature 'Photo albums' do
  let(:user){ create(:user) }
  before { sign_in(user) }

  context 'any visitor' do

    scenario 'can visit their photos page' do
      click_link("Photos")
      expect(page).to have_content("Add Photo")
    end
  end


end
