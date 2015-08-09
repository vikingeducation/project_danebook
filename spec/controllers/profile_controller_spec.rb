# 1. Create
# Creating a user creates a profile

# 2. Edit
# Editing a profile renders the right page
# A user can only see own profile edit page

# 3. Update
# Saving redirects to user timeline
# Failing save renders edit page again

require 'rails_helper'

describe ProfilesController do

	let!(:user){create(:user)}

	before do
		controller_sign_in
	end

	context 'RESTful profile actions' do

		describe 'GET #show' do

			it 'renders user profile' do
				get :show, user_id: user.id
				expect(response).to render_template(:show)
				#sets the right instance variable
				expect(assigns(:profile)).to eq(user.profile)
			end

			it 'renders another users profile' do
				user2 = create(:user)
				get :show, user_id: user2.id
				expect(response).to render_template(:show)
				#sets the right instance variable
				expect(assigns(:profile)).to eq(user2.profile)
			end


			#functionality to be implemented - can only visit a friends' profile
			xit 'should not set a wrong instance variable' do
			 	user2 = create(:user)
				get :show, user_id: user2.id
				expect(response).to render_template(:show)
				#does not set the wrong instance variable
				expect(assigns(:profile)).to_not eq(user.profile)
			end

		end


		describe 'GET #edit' do

			before do
				request.env["HTTP_REFERER"] = "prev_page"
			end

			it 'sets the right instance variable' do
				get :edit, user_id: user.id
				expect(assigns(:profile)).to eq(user.profile)
			end

			it 'renders the users edit page' do
				get :edit, user_id: user.id
				expect(response).to render_template(:edit)
			end

			it 'does not render for user not owning profile' do
				user2 = create(:user)
				get :edit, user_id: user2.id
				expect(response).to redirect_to "prev_page"
			end

			it 'requires used to be logged in' do
				controller_sign_out
				get :edit, user_id: user.id
				expect(response).to redirect_to root_path
			end

		end


		describe 'PUT #update' do

			it 'can only be changed by owner' do

			end

			specify 'saving redirects to user timeline' do
				put :update, user_id: user.id,
										 profile: attributes_for(:profile,
										 about_me: "Controller testing"
										 )
				expect(response).to redirect_to(user_profile_url(user.id))
			end

			specify 'failing save renders edit page again' do
				# put :update, user_id: user.id,
				# 						 profile: attributes_for(:profile,
				# 						 user_id: nil
				# 						 )
				# expect(response).to redirect_to(user_profile_url(user.id))
			end

			specify 'changes are saved successfully' do
				put :update, user_id: user.id,
										 profile: attributes_for(:profile,
										 about_me: "Controller testing"
										 )
				user.reload
				expect(user.profile.about_me).to eq("Controller testing")
			end

		end

	end

end