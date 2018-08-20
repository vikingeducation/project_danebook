require 'rails_helper'

describe 'UsersRequests' do

  describe 'User Access' do

      let(:new_user) {create(:user)}

      describe 'POST #create' do

        before :each do
          post users_path, params: { user: attributes_for(:user) }
        end

        it 'actually creates new user' do
          expect { post users_path,
                   params: { user: attributes_for(:user) } }
                   .to change(User, :count).by(1)
        end

        it 'redirects to timeline when successful' do
          expect(response).to have_http_status(:redirect)
        end

        it 'creates flash message' do
          expect(flash[:success]).not_to be_nil
        end

        it 'sets an authorization token' do
          expect(response.cookies["auth_token"]).not_to be_nil
        end
      end

      describe 'PATCH #update' do

        before :each do
          post session_path, params: { email: new_user.email, password: new_user.password }
        end

        it 'actually updates user info' do
          patch user_path(new_user), params: { user: attributes_for(:user, email: "new_email@gmail.com") }
          new_user.reload
          expect(new_user.email).to eq("new_email@gmail.com")
        end

        it 'redirects if successful' do
          patch user_path(new_user), params: { user: attributes_for(:user, email: "new_email@gmail.com") }
          expect(response).to have_http_status(:redirect)
        end

        it 'renders #edit if not successful' do
          patch user_path(new_user), params: { user: attributes_for(:user, email: "") }
          expect(response).to redirect_to edit_user_profile_path(new_user)
        end

        it 'creates flash message when successful' do
          patch user_path(new_user), params: { user: attributes_for(:user, email: "new_email@gmail.com") }
          expect(flash[:success]).not_to be_nil
        end

        it 'creates flash message when not successful' do
          patch user_path(new_user), params: { user: attributes_for(:user, email: "") }
          expect(flash[:danger]).not_to be_nil
        end

      end

  end

end
