require 'rails_helper'

feature 'as a visitor I would like to visit someones profile' do
  let(:user) { create(:user) }
  let(:profile) { create(:profile, user: user) }
  before do
    user.profile = profile
  end

  scenario 'can visit someones profile without being logged in' do
    visit user_path(user)
    expect(page).to have_content('Foo Bar')
  end

  scenario 'can not visit someones timeline' do
    visit user_timeline_path(user)
    expect(page).to_not have_content('Foo Bar')
  end

  scenario 'can not visit someones about edit page' do
    visit user_about_edit_path(user)
    expect(page).to_not have_content('Foo Bar')
  end

  # scenario 'can not visit someones photos(have not implemented photos yet)'

  # scenario 'can not visit someones friends(have not implemented friends yet)'
end
