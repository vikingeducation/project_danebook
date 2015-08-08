# Flows
# 1. Sign in 
# Cannot view profile page without signing in
# Cannot access any page other than signup page
# Directs to Timeline page

# 2. Sign up
# Requires fields filled correctly
# Fields filled correctly creates user and generates profile
# Directs to profile page after signing up

require 'rails_helper'

describe User do
	
	let(:user){create(:user, :with_profile)}

	before do
		visit root_path
	end

	context 'sign in' do

		scenario 'works with valid email and password' do
			fill_in 'email', with:  user.email
			fill_in 'password_digest', with:  user.password
			click_button 'Log In'
			expect(page).to have_content("Signed in successfully!")
		end

		scenario 'requires valid credentials' do
		 click_button 'Log In'
		 expect(current_url).to eq(root_url) 
		 expect(page).to have_content('ERROR')
		end

		scenario 'redirects user profile on success' do
			fill_in 'email', with:  user.email
			fill_in 'password_digest', with: user.password
			click_button 'Log In'
			expect(current_url).to eq(user_profile_url(user))
		end

		scenario 'is required to access any page' do
			visit user_profile_url(user)
			expect(current_url).to eq(root_url)
			expect(page).to have_css('.error-messages')
		end

	end

	context 'sign up' do
			
		scenario 'requires unique email' do
			fill_in 'user_first_name', with: "James"
			fill_in 'user_last_name', with: "Bond"
			fill_in 'user_email', with: user.email
			fill_in 'user_password', with: "1234567"
			fill_in 'user_password_confirmation', with: "1234567"
			# cannot register a user
			expect{click_button 'Sign Up!'}.to change(User, :count).by(0)
			# returns to sign up page
			expect(current_url).to eq(root_url)
			# shows error message
			expect(page).to have_css('.error-messages')
		end

		scenario 'requires password length greater than 4 chars' do
			fill_in 'user_first_name', with: "James"
			fill_in 'user_last_name', with: "Bond"
			fill_in 'user_email', with: "j@b.com"
			fill_in 'user_password', with: "123"
			fill_in 'user_password_confirmation', with: "123"
			# cannot register a user
			expect{click_button 'Sign Up!'}.to change(User, :count).by(0)
		end

		scenario 'directs to user profile page' do
			fill_in 'user_first_name', with: "James"
			fill_in 'user_last_name', with: "Bond"
			fill_in 'user_email', with: "j@b.com"
			fill_in 'user_password', with: "1234567"
			fill_in 'user_password_confirmation', with: "1234567"
			# registers a user
			expect{click_button 'Sign Up!'}.to change(User, :count).by(1)
			# generates a user profile object 
			expect(User.last.profile.persisted?).to be_truthy
			# expect(Profile.all.count).to eq(2)  #!!! Why does this not work? It returns 1
			# directs to profile page
			expect(current_url).to eq(user_profile_url(User.last))
		end

	end

end