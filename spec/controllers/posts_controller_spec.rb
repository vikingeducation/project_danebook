require 'rails_helper'

describe PostsController do
  let(:user) { create(:user) }
  let(:authored_posts) { create_list(:post, 5, author: user) }
  let(:other_posts) { create_list(:post, 5)}

  it 'should have #index show an index of posts by the given user' do
    get :index, user_id: user.id
    expect(assigns(:posts)).to match_array(authored_posts)
    expect(assigns(:posts)).not_to match_array(other_posts)
  end

  it 'should raise an error if user does not exist' do
    expect{get :index, user_id: -9}.to raise_error(ActiveRecord::RecordNotFound)
  end

  context 'authorized actions' do

    before do
      allow(controller).to receive(:current_user) { user }
    end

    it 'should create a new post if valid params are passed' do
      p = build(:post, author: user)
      p.user_id = user.id
      expect do
        post :create, user_id: user.id, post: p.attributes
      end.to change(Post, :count).by(1)
      expect(assigns(:post).body).to eq(p.body)
      expect(assigns(:post).user_id).to eq(p.user_id)
    end

    it 'should not create a new post if post is blank' do
      p = build(:post, body: "")
      expect do
        post :create, user_id: user.id, post: p.attributes
      end.to change(Post, :count).by(0)
    end

    it 'should allow a user to delete his/her post' do
      create(:post, author: user)
      expect do
        delete :destroy, user_id: user.id, id: user.written_posts.first.id
      end.to change(Post, :count).by(-1)
    end

  end

  context 'unauthorized actions' do

    it 'should not create a new post if not on right user' do
      p = build(:post)
      post :create, user_id: user.id, post: p.attributes
      expect do
        post :create, user_id: user.id, post: p.attributes
      end.to change(Post, :count).by(0)
      expect(response).to redirect_to(user_posts_path(user))
    end

    it 'should not allow a user to delete another user post' do
      create(:post, author: user)
      expect do
        delete :destroy, user_id: user.id, id: user.written_posts.first.id
      end.to change(Post, :count).by(0)
      expect(response).to redirect_to(user_posts_path(user))
    end
  end

end
