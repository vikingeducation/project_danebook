require 'rails_helper'


describe PostsController do

  describe 'GET #index' do

    let(:viewed_user) { create(:user) }
    let(:logged_in_user) { create(:user) }
    let(:post_count) { 2 }

    before do
      post_count.times { viewed_user.posts << build(:post, :poster => viewed_user) }
      request.cookies[:auth_token] = logged_in_user.auth_token
    end


    it 'assigns @user to User being viewed (not current user)' do
      get :index, :user_id => viewed_user
      expect(assigns(:user)).to eq(viewed_user)
    end


    it "gathers all of user's posts into @posts" do
      get :index, :user_id => viewed_user
      expect(assigns(:posts).size).to eq(post_count)
      expect(assigns(:posts)).to eq(viewed_user.posts)
    end


    it 'assigns @new_post with current_user id if signed in' do
      get :index, :user_id => viewed_user
      expect(assigns(:new_post)).to be_a_new(Post)
      expect(assigns(:new_post).poster).to eq(logged_in_user)
    end



    context 'when counting friends' do

      it '@friends size is equal to 6 if total friends > 6' do
        friend_count = 7
        friend_count.times { create(:friending, :friend_initiator => viewed_user) }

        get :index, :user_id => viewed_user

        expect(assigns(:friends).size).to eq(6)
      end


      it '@friends size is equal to total friend count if total < 6' do
        friend_count = 4
        friend_count.times { create(:friending, :friend_initiator => viewed_user) }

        get :index, :user_id => viewed_user

        expect(assigns(:friends).size).to eq(friend_count)
      end

    end



    context 'when counting photos' do

      it '@photos size is equal to 9 if total photos > 9' do
        photo_count = 10
        photo_count.times { create(:photo, :poster => viewed_user) }

        get :index, :user_id => viewed_user

        expect(assigns(:photos).size).to eq(9)
      end


      it '@photos size is equal to total photo count if total < 9' do
        photo_count = 2
        photo_count.times { create(:photo, :poster => viewed_user) }

        get :index, :user_id => viewed_user

        expect(assigns(:photos).size).to eq(photo_count)
      end

    end

  end




  describe 'POST #create' do

    let(:malicious_user) { create(:user) }
    let(:victim) { create(:user) }

    before do
      request.cookies[:auth_token] = malicious_user.auth_token
    end


    it 'rejects when poster_id in params is not current_user' do
      # create a dummy post to prevent false positives below
      create(:post)

      test_post = "I tried to make the victim say this but I failed!"

      post :create, :user_id => victim.id,
                    :post => attributes_for(:post,
                                            :body => test_post,
                                            :poster_id => victim.id)

      expect(flash[:danger]).to eq("You're not authorized to do this!")

      last_post = Post.last
      expect(last_post.poster).not_to eq(victim)
      expect(last_post.body).not_to eq(test_post)
    end

  end

end