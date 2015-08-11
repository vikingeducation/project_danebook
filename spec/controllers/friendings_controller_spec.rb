require 'rails_helper'
require 'pry'


describe FriendingsController do

  let(:user){create(:user)}
  let(:user2){create(:user)}

  context 'friending as logged in user' do

    before :each do
      cookies[:auth_token] = user.auth_token
      user
      user2
      # allow(controller).to receive(:current_user).and_return(user)
    end

    it 'can friend a user' do
      expect do
        post :create, friending: attributes_for(:friending),
                      friend_id: user2.id
      end.to change(Friending, :count).by(1)
    end

    it 'cannot friend a user already friended' do
      friending = create(:friending, friend_id: user2.id,
                          friender_id: user.id)
      expect{friending}.to change(Friending, :count).by(0)
    end


    context 'unfriending' do
      let(:friending) do
        create(:friending, friend_id: user2.id, friender_id: user.id)
      end

      before :each do
        friending
      end

      it 'can unfriend a user' do
        expect do
          post :destroy, id: friending.id, friend_id: user2.id
        end.to change(Friending, :count).by(-1)
      end

      context 'unauthorized unfriending' do

        let(:user3){create(:user)}

        it 'cannot unfriend a user that is not already a friend' do
          expect do
            delete :destroy, id: friending.id, friend_id: user3.id
          end.to change(Friending, :count).by(0)
        end

        it "cannot unfriend someone else's friendship" do
          cookies[:auth_token] = user3.auth_token
          expect do
            post :destroy, id: friending.id, friend_id: user2.id
          end.to change(Friending, :count).by(0)
        end

      end

    end
  end
end
