require 'rails_helper'

describe 'Sessions' do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}

  before do
    visit login_path
    sign_in(user)
  end

  describe 'creation' do
    it 'displays a flash message telling the user they are signed in' do
      expect(page).to have_content('You are now signed in')
    end
  end

  describe 'deletion' do
    it 'displays a flash message telling the user they are signed out' do
      sign_out
      expect(page).to have_content('You are now signed out')
    end

    it 'displays a flash messages telling the user they cannot sign out if they are already signed out' do
      sign_out
      sign_out
      expect(page).to have_content('Please sign in to perform that action')
    end
  end
end