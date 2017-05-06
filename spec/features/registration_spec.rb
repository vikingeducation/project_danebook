require 'rails_helper'

feature 'Registration' do
  let(:user){ {:first_name => 'A', :last_name => 'B', :password => 'foobarfoobar'} }
  before do
    visit root_path
  end
  context 'with valid inputs' do
    after do
      ActiveJob::Base.queue_adapter.enqueued_jobs.clear
    end
    scenario 'can register when inputs are valid' do
      expect{ sign_up(user) }.to change(User, :count).by(1)
    end
    scenario 'displays welcome message' do
      sign_up(user)
      expect(page).to have_content "Success! Welcome to Danebook,"
    end
  end
  context 'with invalid inputs' do
    scenario 'displays error if registration form inputs are invalid' do
      expect{ click_button 'Sign up'}.to change(User, :count).by(0)
      expect(page).to have_content 'We couldn\'t sign you up.'
    end
  end
end
