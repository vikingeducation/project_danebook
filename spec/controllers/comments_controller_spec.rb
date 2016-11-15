require 'rails_helper'

describe CommentsController do
  let(:female){create(:female)}
  let(:user){create(:user, :gender => female)}
  let(:user_post){create(:post, :user => user)}
  let(:post_comment){create(:post_comment, :user => user, :commentable => user_post)}

  before do
    user_post
    login(user)
  end

  describe 'POST #create' do
    let(:post_create_comment) do
      post :create, :user_id => user.id,
                    :comment => attributes_for(
                      :post_comment,
                      :commentable_id => user_post,
                      :commentable_type => user_post.class.name,
                      :body => FactoryHelper.text
                    )
    end

    let(:post_create_invalid) do
      post :create, :user_id => user.id,
                    :comment => attributes_for(
                      :post_comment,
                      :commentable_id => nil,
                      :commentable_type => '',
                      :body => ''
                    )
    end

    context 'the user is signed in' do
      it 'saves a new comment when valid' do
        expect {post_create_comment}.to change(Comment, :count).by(1)
      end

      it 'sets a success flash message when valid' do
        post_create_comment
        expect(flash[:success]).to_not be_nil
      end

      it 'does not save a comment when invalid' do
        expect {post_create_invalid}.to change(Comment, :count).by(0)
      end

      it 'sets an error flash message when invalid' do
        post_create_invalid
        expect(flash[:error]).to_not be_nil
      end
    end

    context 'the user is signed out' do
      before do
        logout
      end

      it 'does not create a comment' do
        expect {post_create_comment}.to change(Comment, :count).by(0)
      end

      it 'redirects the user to root path' do
        post_create_comment
        expect(response).to redirect_to root_path
      end

      it 'sets a flash error message' do
        post_create_comment
        expect(flash[:error]).to_not be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_destroy_comment){delete :destroy, :id => post_comment.id, :user_id => user.id}
    let(:delete_destroy_invalid){delete :destroy, :id => '1234', :user_id => user.id}

    before do
      post_comment
    end

    context 'the user is signed in' do
      it 'destroys the comment when valid' do
        expect {delete_destroy_comment}.to change(Comment, :count).by(-1)
      end

      it 'sets a success flash message when valid' do
        delete_destroy_comment
        expect(flash[:success]).to_not be_nil
      end

      it 'does not destroy the comment when invalid' do
        expect {delete_destroy_invalid}.to change(Comment, :count).by(0)
      end

      it 'sets an error flash message when invalid' do
        delete_destroy_invalid
        expect(flash[:error]).to_not be_nil
      end
    end

    context 'the user is signed out' do
      before do
        logout
      end

      it 'does not destroy a comment' do
        expect {delete_destroy_comment}.to change(Comment, :count).by(0)
      end

      it 'redirects the user to root path' do
        delete_destroy_comment
        expect(response).to redirect_to root_path
      end

      it 'sets a flash error message' do
        delete_destroy_comment
        expect(flash[:error]).to_not be_nil
      end
    end
  end
end





