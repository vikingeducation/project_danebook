# Flows
# 1. Create a post
# Can only create post on own wall

# 2. Delete a post
# Can only delete own post

require 'rails_helper'

describe Post do

	let(:user){create(:user, :with_profile)}
	
	before do
		visit root_path
		fill_in 'email', with:  user.email
		fill_in 'password_digest', with:  user.password
		click_button 'Log In'
	end

	context 'creation' do
		scenario 'can create post on own timeline' do
			visit user_timeline_path(user)
			fill_in 'post_body', with: "This is a capy post"
			click_button 'Post'
			#checking that user did create post
			expect(page).to have_content("#{user.first_name} #{user.last_name} Posted on")
			#checking that user created post was rendered
			expect(page).to have_content("This is a capy post")
		end

		scenario 'cannot create post on other users timeline' do
			user2 = create(:user)
			visit user_timeline_path(user2)
			save_and_open_page
			#checking that text area does not render
			expect(page).to_not have_css('.post_body')
			expect(page).to_not have_button('Post')
		end

	end

	context 'deletion' do
		scenario 'only allowed by creator' do

		end
	end

end
