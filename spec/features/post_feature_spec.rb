require 'rails_helper'

describe Post do

	let(:user){create(:user)}

	before do
		sign_in
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
			#checking that text area does not render
			expect(page).to_not have_css('.post_body')
			expect(page).to_not have_button('Post')
		end

	end

	context 'deletion' do

		scenario 'only allowed by creator' do
			user2 = create(:user)
			create(:post, user: user2)
			visit user_timeline_path(user2)
			expect(page).to_not have_content('Delete')
			# click_link 'Delete'
			# expect(page).to have_content('ERROR')
		end

		scenario 'owner can delete post' do
			post = create(:post, user: user)
			visit user_timeline_path(user)
			click_link 'Delete'
			expect(page).to_not have_content(post.body)
			expect(page).to have_content("SUCCESS: Post deleted")
			expect(current_url).to eq user_timeline_url(user)
		end

	end
end
