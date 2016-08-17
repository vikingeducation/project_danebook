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

    end

  end

  context 'when the user is not logged in'

  context 'when the timeline does not exist'

end