require 'rails_helper'

feature 'Edit Profile' do
  let(:user){ create(:user) }
  let(:other_user){ create(:user) }

  context 'edit own profile' do

    before do
      visit root_path
      sign_in(user)
      visit(edit_user_path(user))
    end

    specify "edit profile link on user's own about page" do
      expect(page).to have_link('Edit Profile')
    end

    specify 'access own edit form' do
      expect(current_path).to eq(edit_user_path(user))
    end

    specify "not permitted to access other user's edit form" do
      visit(edit_user_path(other_user))
      expect(current_path).not_to eq(edit_user_path(other_user))
    end

    specify 'prevented from submitting invalid params' do
      fill_in 'user[profile_attributes][telephone]', with: "asdjfklajsdklfjklaskdfljalsdfasdf"
      click_button('Save Changes')
      expect(page).to have_content("Profile telephone is too long")
    end

    specify 'successfully edits own profile' do
      fill_in 'user[profile_attributes][words]', with: 'hello hello'
      click_button('Save Changes')
      expect(page).to have_content('Profile updated!')
    end
  end



end