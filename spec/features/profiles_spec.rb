require 'rails_helper'

feature 'Edit details in user account' do
  let(:user){create(:user)}
  let(:profile){create(:profile, :user_id => user.id)}

  before do
    user
    profile
    sign_in(user)
    visit user_path(user)
    click_link "Edit Your Profile"
  end

  scenario "Successfull change of school name" do
    fill_in('user_profile_attributes_college', :with => 'Trinity College')
    click_button "Save Changes"
    expect(page).to have_content "successfully"
    expect(page).to have_css ('div.alert-success')
  end

  scenario "Unable to edit with too short words to live by section" do
    fill_in('user_profile_attributes_words_to_live', :with => 'Hellohohoho')
    click_button "Save Changes"
    expect(page).to have_content "We couldn't edit your profile!"
    expect(page).to have_css ('div.alert-danger')
  end


end
