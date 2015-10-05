require 'rails_helper'

describe User do

	let(:user){create(:user)}

	context 'sign in' do

		scenario 'works with valid email and password' do
			sign_in
			expect(page).to have_content("Signed in successfully!")
		end

		scenario 'requires valid credentials' do
		 visit root_path
		 click_button 'Log In'
		 expect(current_url).to eq(root_url)
		 expect(page).to have_content('ERROR')
		end

		scenario 'redirects user profile on success' do
			sign_in
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
			fill_sign_up_form(email: user.email)
			# cannot register a user
			expect{click_button 'Sign Up!'}.to change(User, :count).by(0)
			# returns to sign up page
			expect(current_url).to eq(root_url)
			# shows error message
			expect(page).to have_css('.error-messages')
		end

		scenario 'requires password length greater than 4 chars' do
			fill_sign_up_form(pwd: "123", pwd_confirmation: "123" )
			# cannot register a user
			expect{click_button 'Sign Up!'}.to change(User, :count).by(0)
		end

		scenario 'directs to user profile page' do
			fill_sign_up_form
			# registers a user
			expect{click_button 'Sign Up!'}.to change(User, :count).by(1)
			# generates a user profile object
			expect(Profile.all.count).to eq(1)
			# directs to profile page
			expect(current_url).to eq(user_profile_url(User.last))
		end

	end
end