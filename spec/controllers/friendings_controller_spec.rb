require 'rails_helper'

describe FriendingsController do

  describe 'Users can friend other users' do
    let(:user) { create(:user) }
    let(:otheruser) { create(:user) }
    describe 'friendings#create' do
      context 'with valid attributes' do
        before do
          login_user
          post :create, params: { friending: {friendee: otheruser} }
        end

        it "redirects to the recently friended user's timeline page" do
          expect(response).to redirect_to user_timeline_path(otheruser)
        end

        it 'flashes success' do
          expect(flash[:success]).to_not be_nil
        end
      end

      context 'but without valid attributes' do
        before do
          login_user
          post :create, params: { friending: {friendee: user} }
        end

        it 'they are redirected back to the root path' do
          expect(response).to redirect_to root_url
        end

        it 'flashes an error' do
          expect(flash[:error]).to_not be_nil
        end
      end
    end
  end
end
