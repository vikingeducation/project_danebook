require 'rails_helper'

describe 'CommentsRequests' do
  let(:user){ create(:user, :with_profile)}
  let(:posting){ create(:post, user: user)}
  let(:comment){ create(:comment, :for_post)}

  def create_comment(user)
    post post_comments_path(posting), params: { comment: attributes_for(:comment, user: user)  }
  end
  describe 'POST #create' do
    it 'requires logged in user' do
      expect{ post post_comments_path(posting) }.not_to change(Comment, :count)
      expect(response).to redirect_to new_user_session_path
    end
    context 'logged in' do
      before do
        login_as(user, scope: :user)
      end
      it 'creates a comment' do
        expect{  create_comment(user) }.to change(Comment, :count).by(1)
      end
    end
  end
  describe 'DELETE #destroy' do
    it 'requires user to be logged in' do
      comment
      expect{ delete comment_path(comment)}.not_to change(Comment, :count)
    end
    it 'can only delete own comment' do
      comment = create(:comment, :for_post, user: create(:user))
      expect{ delete comment_path(comment)}.not_to change(Comment, :count)
    end
  end
end
