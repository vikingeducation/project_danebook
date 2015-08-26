require 'rails_helper'


feature 'Edit User Profile' do

  let(:user) { create(:user, :profile => build(:base_profile)) }
  let(:full_profile_fields) { build(:full_profile) }

  before do
    sign_in(user)
    visit(user_path(user))
    click_link 'Edit your profile'
  end


  scenario 'with valid input' do
    fill_out_user_profile(full_profile_fields)

    click_button 'Save Changes'

    expect(page).to have_content 'Profile updated'
    expect(page).to have_content full_profile_fields.hometown
    expect(page.current_path).to eq(user_path(user))
  end


  scenario 'with a valid blank input' do
    fill_out_user_profile(full_profile_fields)

    fill_in 'user_profile_attributes_telephone', with: ""

    click_button 'Save Changes'

    expect(page).to have_content 'Profile updated'
    expect(page).to have_content full_profile_fields.hometown
    expect(page).not_to have_content 'Telephone:'
    expect(page).not_to have_content full_profile_fields.telephone
    expect(page.current_path).to eq(user_path(user))
  end


  scenario 'with invalid input' do
    fill_out_user_profile(full_profile_fields)

    invalid_town = "a"*65
    fill_in 'user_profile_attributes_hometown', with: invalid_town

    click_button 'Save Changes'

    expect(page).to have_content 'error'
    expect(page).not_to have_content invalid_town
    expect(page.current_path).to eq(user_path(user))
  end


  scenario 'for an unauthorized user' do
    other_user = create(:user, :profile => full_profile_fields)
    visit edit_user_path(other_user)

    # what about forcing in some edit params without hitting Edit page?

    expect(page).to have_content 'not authorized'
    expect(page.current_path).to eq(root_path)
  end

end


feature 'Search by first or last name' do

  let(:user) { create(:user) }
  let(:user_to_find) { create(:user) }

  before do
    sign_in(user)
  end

  it 'finds the target user' do
    fill_in "search", with: user_to_find.profile.last_name
    click_button "Search!"
    expect(page.current_path).to eq(search_path)
    expect(page).to have_content(user_to_find.profile.first_name)
  end

end