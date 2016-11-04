require 'rails_helper'

feature 'Users may only view content relevant to them' do

  let(:user) { create(:user) }
  let(:otheruser) { create(:user) }
  let(:profile) { create(:profile) }

  before do
    user.profile = profile
    login(user)
  end

  scenario 'I visit my own timeline page' do
    visit user_timeline_path(user)
    find(:id, 'post_post_text')
  end

  scenario 'I can post something to my timeline' do
    visit user_timeline_path(user)
    fill_in('post_post_text', with: 'DISMYPOSTYALL')
    click_button('Post')
    expect(page).to have_content('DISMYPOSTYALL')
  end

  scenario 'I do not see a field to post in on anyone elses timeline page' do
    visit user_timeline_path(otheruser)
    expect(page).to_not have_selector(:id, 'post_post_text')
  end

  scenario 'I visit my own about edit page' do
    visit user_about_edit_path(user)
    expect(page).to have_selector(:id, 'user_profile_attributes_currently_lives')
  end

  scenario 'I edit my profile' do
    visit user_about_edit_path(user)
    fill_in('user_profile_attributes_currently_lives', with: 'Antarctica')
    click_button('Save Changes')
    expect(page).to have_content('Antarctica')
  end

  scenario "I can not visit anyone else's about_edit page" do
    visit user_about_edit_path(otheruser)
    expect(page).to_not have_selector(:id, 'user_profile_attributes_currently_lives')
  end

end
