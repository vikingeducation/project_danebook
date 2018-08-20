require 'rails_helper'

describe 'LikesRequests' do

  let(:user){ create(:user) }
  let(:user_post){ create(:post, user_id: user.id) }

  describe 'User Access' do

    before :each do
      post session_path, params: {email: user.email, password: user.password}
    end

    describe 'POST #create' do

      it 'actually creates a like' do
        expect{ post like_path, params: { like: {likable_id: user_post.id, likable_type: 'Post', user_id: user.id}}}.to change(Like, :count).by(1)
      end

      it 'creates a flash message' do
        expect(flash[:success]).to_not be_nil
      end

    end

    describe 'DELETE #destroy' do

      before :each do
        post like_path, params: { like: {likable_id: user_post.id, likable_type: 'Post', user_id: user.id}}
      end

      it 'actually deletes the like' do
        expect{ delete like_path, params: { like: {likable_id: user_post.id, likable_type: 'Post', user_id: user.id}}}.to change(Like, :count).by(-1)
      end

      it 'creates flash message' do
        delete like_path, params: { like: {likable_id: user_post.id, likable_type: 'Post', user_id: user.id}}
        expect(flash[:success]).to_not be_nil
      end

    end

  end

end
