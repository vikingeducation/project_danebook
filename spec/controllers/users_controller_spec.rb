require 'rails_helper'

describe UsersController do

  describe 'Users can sign up' do
    describe 'users/create' do
      context 'with valid attributes' do
        it 'redirects to users timeline page' do
          post :create, params: { user: attributes_for(:user) }
          expect(response).to redirect_to user_timeline_path('1')
        end
      end

      context 'without valid attributes' do
        it 'renders home page if provided invalid attributes' do
          post :create, params: { user: attributes_for(:user, email: '') }
          expect(response).to render_template 'static_pages/home'
        end
      end
    end
  end

  describe 'users can edit their profile' do
    let(:user) { create(:user) }

    before do
      login_user
    end

    describe 'users/update' do
      context 'with valid attributes' do

        let(:updated_email) { 'updatedemail@example.com' }
        before do
          put :update, params: { id: user.id, user: attributes_for(:user, email: updated_email) }
        end

        it 'redirects to users show page' do
          expect(response).to redirect_to user_path(user)
        end

        it 'successfully updates the user' do
          user.reload
          expect(user.email).to eq(updated_email)
        end

        it 'flashes success' do
          expect(flash[:success]).to_not be_nil
        end
      end

      context 'without valid attributes' do
        let(:bad_updated_email) { 'example.com' }
        before do
          put :update, params: { id: user.id, user: attributes_for(:user, email: bad_updated_email) }
        end

        it 'redirects to the users edit page' do
          expect(response).to render_template 'static_pages/about_edit'
        end

        it 'flashes an error' do
          expect(flash[:error]).to_not be_nil
        end

        it 'sets the user instance variable' do
          expect(assigns(:user)).to eq(user)
        end
      end

      context 'with malicious intent' do
        it 'updates that current user, even with different user id' do
          otheruser = create(:user)
          put :update, params: { id: otheruser.id, user: attributes_for(:user) }
          expect(flash[:success]).to eq('Successfully updated your profile!')
        end
      end
    end
  end
end
