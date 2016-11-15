require 'rails_helper'

describe LikesController do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:user_post){create(:post, :user => user)}
  let(:like){create(:post_like, :user => user, :likeable => user_post)}

  before do
    login(user)
  end

  describe 'POST #create' do
    let(:post_create_like) do
      post :create, :user_id => user.id,
                    :likeable_id => user_post.id,
                    :likeable_type => user_post.class.name
    end

    let(:post_create_invalid) do
      post :create, :user_id => user.id,
                    :likeable_id => '1234',
                    :likeable_type => ''
    end

    context 'the user is signed in' do
      it 'creates a new like when valid' do
        expect {post_create_like}.to change(Like, :count).by(1)
      end

      it 'sets a success flash when valid' do
        post_create_like
        expect(flash[:success]).to_not be_nil
      end

      it 'does not create a new like when invalid' do
        expect {post_create_invalid}.to change(Like, :count).by(0)
      end

      it 'sets an error flash when invalid' do
        post_create_invalid
        expect(flash[:error]).to_not be_nil
      end
    end

    context 'the user is signed out' do
      before do
        logout
      end

      it 'does not create a new like' do
        expect {post_create_like}.to change(Like, :count).by(0)
      end

      it 'redirects to the root path' do
        post_create_like
        expect(response).to redirect_to root_path
      end

      it 'sets an error flash' do
        post_create_like
        expect(flash[:error]).to_not be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_destroy_like) do
      delete :destroy,  :id => like.id,
                        :user_id => user.id,
                        :likeable_id => user_post.id,
                        :likeable_type => user_post.class.name
    end

    let(:delete_destroy_invalid) do
      delete :destroy,  :id => '1234',
                        :user_id => user.id
    end

    before do
      like
    end

    context 'the user is signed in' do
      it 'destroys the like when valid' do
        expect {delete_destroy_like}.to change(Like, :count).by(-1)
      end

      it 'sets a success flash when valid' do
        delete_destroy_like
        expect(flash[:success]).to_not be_nil
      end

      it 'does not destroy the like when invalid' do
        expect {delete_destroy_invalid}.to change(Like, :count).by(0)
      end

      it 'sets an error flash when invalid' do
        delete_destroy_invalid
        expect(flash[:error]).to_not be_nil
      end
    end

    context 'the user is signed out' do
      before do
        logout
      end

      it 'does not destroy the like' do
        expect {delete_destroy_like}.to change(Like, :count).by(0)
      end

      it 'redirects to root path' do
        delete_destroy_like
        expect(response).to redirect_to root_path
      end

      it 'sets an error flash' do
        delete_destroy_like
        expect(flash[:error]).to_not be_nil
      end
    end
  end
end

