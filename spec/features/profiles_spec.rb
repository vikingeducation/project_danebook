require 'rails_helper'

describe 'Profile' do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:words_to_live_by){'This is my life and it is now or never!'}

  before do
    visit login_path
    sign_in(user)
  end

  describe 'editing' do
    it 'results in the profile being updated with the submitted data' do
      visit edit_user_path(user)
      fill_in('user_profile_attributes_words_to_live_by', :with => words_to_live_by)
      find('input[value="Save Changes"]').click
      expect(page).to have_content(words_to_live_by)
    end
  end
end