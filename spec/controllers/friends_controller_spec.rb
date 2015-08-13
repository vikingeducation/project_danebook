require 'rails_helper'
require 'pry'

describe FriendingsController do
  describe 'friend CRUD' do
    let(:user){ create(:user) }
    let(:another_user){ create(:user) }
    let(:friendship){ Friend.create(:user_id => user.id,
                                    :friend_id => another_user.id) }

    before :each do
      # session[:user_id] = user.id
      request.cookies["auth_token"] = user.auth_token
    end

    describe 'POST #create' do

      it 'redirects to the friended user' do
        post :create, :user_id => user.id,
                      :friend_id => another_user.id
        expect(response).to redirect_to user_posts_path(another_user.id)
      end

      # adds friended user to user
      # also adds current user to friended user friends
      it 'should create two friendships' do
        expect{ post :create, :user_id => user.id, :friend_id => another_user.id }.to change(Friend, :count).by(2)
      end
    end

    describe 'GET #index' do
      let(:third_user){ create(:user) }

      it 'collects friends into @friends' do
        Friend.create(:user_id => user.id,
                      :friend_id => third_user.id)
        Friend.create(:user_id => user.id,
                      :friend_id => another_user.id)
        get :index, :user_id => user.id
   
        expect(assigns(:friends)).to eq(user.friends)

      end
    end

    describe 'DELETE #destroy' do

      it 'redirects to the current users friends path' do
        delete :destroy, :user_id => user.id, 
                         :friend_id => another_user.id,
                         :id => user.id
        expect(response).to redirect_to user_friendings_path(user)
      end

      it 'destroys the friendship both ways' do
        expect{ delete :destroy, :user_id => user.id, 
                         :friend_id => another_user.id,
                         :id => user.id }.to change(Friend, :count).by(-1)
      end
    end
  end
end