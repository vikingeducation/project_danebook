
require 'rails_helper'

describe 'CommentsRequests' do


  describe 'User Access' do

    let(:user){ create(:user) }
    let(:user_profile){ create(:profile, user_id: user.id) }
    let(:user_post){ create(:post, user_id: user.id) }
    let(:user_comment){ create(:comment, commentable_id: user_post.id) }

    before :each do
      post session_path, params: { email: user.email, password: user.password }
    end


    describe 'POST #create' do

      it 'actually creates a comment' do
        expect { post comments_path, params: { comment: attributes_for(:comment, user_id: user.id) } }.to change(Comment, :count).by(1)
      end

      it 'creates flash message and redirects you back to timeline' do
        post comments_path, params: { comment: attributes_for(:comment, user_id: user.id) }
        expect(flash[:success]).not_to be_nil
        expect(response).to redirect_to user_timeline_path(user)
      end

    end

    describe 'DELETE #destroy' do

      it 'actuallly deletes the comment' do
        user_comment
        expect { delete comment_path(user_comment) }.to change(Comment, :count).by(-1)
      end

      it 'creates flash message and redirect you to timeline' do
        delete comment_path(user_comment)
        expect(flash[:success]).not_to be_nil
        expect(response).to redirect_to user_timeline_path(user)
      end

      it 'for another user does not delete comment, creats flash message and redirects' do
        another_user = create(:user)
        user_comment
        post session_path, params: { email: another_user.email, password: another_user.password }
        expect { delete comment_path(user_comment) }.to change(user_post.comments, :count).by(0)

        delete comment_path(user_comment)
        expect(flash[:danger]).not_to be_nil
        expect(response).to redirect_to user_timeline_path(another_user)
      end

    end

  end

  describe 'Non-User Access' do

    let(:user){ create(:user) }
    let(:user_profile){ create(:profile, user_id: user.id) }
    let(:user_post){ create(:post, user_id: user.id) }
    let(:user_comment){ create(:comment, commentable_id: user_post.id) }

    describe 'POST #create' do

      it 'does not create new post' do
        expect { post comments_path, params: { comment: attributes_for(:comment, user_id: user.id) } }.to change(Comment, :count).by(0)
      end

      it 'redirect you to home page and creates flash message' do
        post comments_path, params: { comment: attributes_for(:comment, user_id: user.id) }
        expect(response).to redirect_to root_path
        expect(flash[:danger]).not_to be_nil
      end

    end

    describe 'DELETE #destroy' do

      it 'does not destroy comment' do

      end

      it 'redirects you to homepage and creates flash message' do
      end

    end

  end

end
