require 'rails_helper'
describe UsersController do
  # let(:user) { profile.user }
  # let(:profile) { create(:profile) }

  describe 'POST #create' do
    context 'with valid input' do
      it 'creates users' do
        expect {
          process :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end
      it 'redirects to timeline' do
        process :create, params: { user: attributes_for(:user) }
        expect(response).to redirect_to(edit_user_profile_path(User.last))
      end
      it 'authenticates user' do
        process :create, params: { user: attributes_for(:user) }
           expect(cookies[:auth_token]).to eq(User.last.auth_token)
        end
      end
      context 'with invalid input' do
        it 'doesn\'t create user' do
          expect {
            process :create, params: { user: attributes_for(:user, password: 'no') }
          }.to change(User, :count).by(0)
        end

        it 'doesn\'t create user' do
          process :create, params: { user: attributes_for(:user, password: 'no') }
          expect(flash[:error]).to eq("Try again")
        end
      end


  end
end
