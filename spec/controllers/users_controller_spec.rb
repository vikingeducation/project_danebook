require 'rails_helper'

describe UsersController do

	let(:user) { build(:user) }

	context 'RESTful user actions' do

		describe 'GET #new' do

			it 'renders the new user page' do
				get :new
				expect(response).to render_template :new
			end

		end

		describe 'POST #create' do

			specify 'valid submissions create new user' do
				expect do
					post :create, user: attributes_for(:user)
				end.to change(User, :count).by(1)
			end

			it 'redirects to the profile page' do
				post :create, user: attributes_for(:user)
				expect(response).
				to redirect_to user_profile_path(assigns(:user))
			end

		end

		context 'Logged in User' do

			before do
				user.save
				session[:user_id] = user.id
			end

			#functionality to be implemented
			describe 'DELETE #destroy' do

				xit 'can delete own account' do
					binding.pry
					expect do
						delete :destroy, id: user.id
					end.to change(User, :count).by(-1)
				end

				xit 'cannot delete another users account' do
					user2 = create(:user)
					expect{delete :destroy, id: user2.id}.
					to change(User, :count).by(0)
				end

			end

		end
	end
end