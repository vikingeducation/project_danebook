require 'rails_helper'


describe CommentsController do


  describe 'POST #create' do

    let(:initiator) { create(:user) }
    let(:victim) { create(:user) }
    let(:parent_post) { create(:post) }

    before do
      request.cookies[:auth_token] = initiator.auth_token
    end


    it 'does not allow the current user from changing the author_id in params' do
      # create a dummy comment to prevent false positives below
      create(:comment)

      test_comment = "I tried to make the victim say this but I failed!"
      post :create, :comment => attributes_for(:comment,
                                                :body => test_comment,
                                                :author_id => victim.id,
                                                :post_id => parent_post.id)

      created_comment = Comment.last

      expect(created_comment.author).to eq(initiator)
      expect(created_comment.body).to eq(test_comment)
    end

  end


  describe 'POST #destroy' do

    let(:comment) { create(:comment) }

    it 'redirects to the Post that the deleted Comment was under' do
      delete :destroy, id: comment.id
      expect(response).to redirect_to user_posts_path(comment.post.author)
    end

  end


end