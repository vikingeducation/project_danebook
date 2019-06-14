require 'rails_helper'

RSpec.feature 'FriendingAndUnfriending', type: :feature do
  before do
    visit root_path
  end

  context 'Visitors' do
    context "As a visitor" do

  #     scenario "I want to sign up" do
  #       click_link('Sign up')

  #       name = 'foo'
  #       fill_in('Name', with: name)
  #       fill_in('Email', with: "#{name}#@email.com")
  #       fill_in('Password', with: 'password')
  #       fill_in('Password confirmation', with: 'password')

  #       expect{ click_button("Create User") }.to change(User, :count).by(1)
  #       expect(page).to have_content(name)
  #       expect(page).to have_content("User was successfully created")
  #     end

  #     scenario "I want to be notified of form problems when signing up" do
  #       click_link('Sign up')

  #       name = 'f'
  #       fill_in('Name', with: name)
  #       fill_in('Email', with: "#{name}#@email.com")
  #       fill_in('Password', with: 'password')
  #       fill_in('Password confirmation', with: 'password')

  #       click_button("Create User")
  #       expect(page).to have_content('too short')
  #     end
    end #as a visitor
  end #visitors

  # context 'User accounts' do
  #   let(:user){ create(:user) }

  #   context "As a not-signed-in user" do
  #     scenario "I want to sign in to my account" do
  #       login(user)
  #       expect(page).to have_content(user.name)
  #     end
  #   end

  #   context "As a signed-in user" do
  #     scenario "I want to be able to create a secret" do
  #       login(user)

  #       visit secrets_path
  #       expect(page).to have_content('New Secret')
  #       click_link('New Secret')

  #       title = generate_string(15)
  #       fill_in('Title', with: title )
  #       fill_in('Body', with: generate_string(130))
  #       expect{ click_button("Create Secret") }.to change(Secret, :count).by(1)
  #       expect(page).to have_content(title)
  #       expect(page).to have_content("Secret was successfully created")
  #     end

  #     scenario "I want to be notified of form issues when creating a secret" do
  #       login(user)

  #       visit secrets_path
  #       expect(page).to have_content('New Secret')
  #       click_link('New Secret')

  #       title = generate_string(1)
  #       fill_in('Title', with: title )
  #       fill_in('Body', with: generate_string(130))
  #       click_button("Create Secret")
  #       expect(page).to have_content('too short')
  #     end

  #     scenario "I want to be able to edit one of my secrets" do
  #       login(user)
  #       secret = create_secret(user)
  #       visit root_path

  #       click_link('Edit')
  #       expect(current_path).to eq(edit_secret_path(secret))
  #       expect(page).to have_content('Edit')

  #       changed_title = 'Changed Title'
  #       fill_in('Title', with: changed_title)
  #       click_button('Update Secret')

  #       expect(page).to have_content('Secret was successfully updated')
  #       expect(page).to have_content(changed_title)
  #     end

  #     scenario "I want to be notified of form issues when editing a secret" do
  #       login(user)
  #       secret = create_secret(user)
  #       visit root_path

  #       click_link('Edit')
  #       expect(current_path).to eq(edit_secret_path(secret))
  #       expect(page).to have_content('Edit')

  #       changed_title = generate_string(1)
  #       fill_in('Title', with: changed_title)
  #       click_button('Update Secret')
  #       expect(page).to have_content('too short')
  #     end

  #     scenario "I want to be able to delete one of my secrets" do
  #       login(user)
  #       secret = create_secret(user)
  #       visit root_path

  #       click_link('Destroy')
  #       expect(page).to_not have_content(secret.title)
  #     end
  #   end
  # end


end
