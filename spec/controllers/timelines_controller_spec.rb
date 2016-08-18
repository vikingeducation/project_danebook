require 'rails_helper'

describe TimelinesController do
  let(:timeline) { create(:timeline) }
  let(:user) { 
    user = timeline.user

    # making friends
    5.times do
      user.friends << create(:user)
    end
    user
  }
  let(:new_user) { 
    user = timeline.user

    # making friends
    5.times do
      user.friends << create(:user)
    end
    user
  }
  let(:logging_in_user) {

    session[:user_id] = user.id
    controller.stub(:current_user) { user }

  }
  let(:profile) { 

    user.profile

  }




  context 'when the user is logged in' do

    before do

      logging_in_user

    end

    context 'when viewing his own timeline' do

      before do

        get :show, id: user.timeline_id

      end

      it 'assigns variables multiple related instance variables' do

        expect(assigns(:timeline)).to be_a(Timeline)
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:profile)).to be_a(Profile)
        expect(assigns(:post)).to be_a(Post)
        expect(assigns(:like)).to be_a(Like)
        expect(assigns(:comment)).to be_a(Comment)
        expect(assigns(:friends).first.friendable_id).to eq(user.id)

      end

      it 'responds with a 200 status code' do

        expect(response.code).to eq('200')

      end

    end

    context 'when viewing someone else\'s timeline' do

      before do
        # making friends
        5.times do
          new_user.friends << create(:user)
        end
        get :show, id: new_user.timeline_id

      end

      it 'assigns variables multiple related instance variables' do

        expect(assigns(:timeline)).to be_a(Timeline)
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:profile)).to be_a(Profile)
        expect(assigns(:post)).to be_a(Post)
        expect(assigns(:like)).to be_a(Like)
        expect(assigns(:comment)).to be_a(Comment)
        expect(assigns(:friends).first.friendable_id).to eq(new_user.id)

      end

      it 'responds with a 200 status code' do

        expect(response.code).to eq('200')

      end

    end

  end

  context 'when the user is not logged in' do

    before do

      get :show, id: user.timeline_id

    end

    it 'does not assign the related instance variables' do

        expect(assigns(:timeline)).to be_nil
        expect(assigns(:user)).to be_nil
        expect(assigns(:profile)).to be_nil
        expect(assigns(:post)).to be_nil
        expect(assigns(:like)).to be_nil
        expect(assigns(:comment)).to be_nil
        expect(assigns(:friends)).to be_nil

    end

    it "warns the user with a notice" do

      expect(flash[:notice]).to eq("You must first log in.")

    end

    it "redirects the user to the login page" do

      expect(response).to redirect_to(login_path)

    end

  end

  context 'when the timeline does not exist' do

    before do

      logging_in_user
      get :show, id: 123456

    end

    it 'warns the user with an error flash' do

      expect(flash[:danger]).to eq("Error! Timeline doesn't exist!")

    end

    it "redirects the user to the root path" do

      expect(response).to redirect_to(root_path)

    end

  end

end