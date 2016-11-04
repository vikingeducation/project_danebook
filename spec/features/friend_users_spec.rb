require 'rails_helper'

feature 'Friending functionality' do
  let(:user) { create(:user) }
  let(:otheruser) { create(:user) }
  let(:profile) { create(:profile, user: user) }
  let(:otherprofile) { create(:profile, user: otheruser) }

  before do
    otheruser
    profile
    otherprofile
    login(user)
    @user = user
    def current_user
      @user
    end
  end


  scenario "I would like to friend someone I'm not friends with" do
    visit user_timeline_path(otheruser)
    within('#friend-button-container') do
      click_link('Friend') #gives a false positive
    end
    expect(page).to have_content('Unfriend')
  end

end
