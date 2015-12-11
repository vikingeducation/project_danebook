require 'rails_helper'

describe ActivitiesController do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:friend){create(:user, :gender => male)}
  let(:post){create(:post, :user => user)}
  let(:friend_request){create(:friend_request, :initiator => user, :approver => friend)}
  let(:activity){Activity.first}

  before do
    post
    friend_request.accept
  end

  describe 'GET #index' do
    context 'the user is signed in' do
      before do
        login(user)
      end

      it 'sets an instance variable to the activity feed for the user' do
        get :index
        expect(assigns(:activities)).to eq(Activity.feed_for(user))
      end
    end

    context 'the user is signed out' do
      it 'redirects to the signup path' do
        get :index
        expect(response).to redirect_to signup_path
      end
    end
  end

  describe 'GET #show' do
    context 'the user is signed in' do
      before do
        login(user)
      end

      it 'sets an instance variable to the timeline activity for the user' do
        get :show, :user_id => user.id
        expect(assigns(:activities)).to eq(Activity.timeline_for(user))
      end
    end

    context 'the user is signed out' do
      it 'redirects to the signup path' do
        get :show, :user_id => user.id
        expect(response).to redirect_to signup_path
      end

      it 'sets an error flash' do
        get :show, :user_id => user.id
        expect(flash[:error]).to_not be_nil
      end
    end
  end
end
