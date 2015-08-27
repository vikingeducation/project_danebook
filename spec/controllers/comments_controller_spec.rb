require 'rails_helper'


describe CommentsController do


  describe 'POST #create' do

    let(:initiator) { create(:user) }
    let(:victim) { create(:user) }
    let(:parent_post) { create(:post) }

    before do
      request.cookies[:auth_token] = initiator.auth_token
      request.env["HTTP_REFERER"] = user_posts_path(victim)
    end


    it 'does not allow the current user from changing the author_id in params' do
      # create a dummy comment to prevent false positives below
      create(:comment, :on_post)

      test_comment = "I tried to make the victim say this but I failed!"
      post :create, :comment => attributes_for( :comment,
                                                :body => test_comment,
                                                :author_id => victim.id,
                                                :commentable_id => parent_post.id,
                                                :commentable_type => parent_post.class )

      created_comment = Comment.last

      expect(created_comment.author).to eq(initiator)
      expect(created_comment.body).to eq(test_comment)
    end


    it 'should call Comment.send_notification(@comment.id)' do
      test_id = create(:comment).id + 1
      allow(Comment).to receive(:send_notification).and_return(true)
      expect(Comment).to receive(:send_notification).with(test_id)
      post :create, :comment => attributes_for( :comment,
                                                :commentable_id => parent_post.id,
                                                :commentable_type => parent_post.class )
    end

  end


  describe 'POST #destroy' do

    let(:comment) { create(:comment, :on_post) }

    it 'redirects to the Post that the deleted Comment was under' do
      delete :destroy, id: comment.id
      expect(response).to redirect_to user_posts_path(comment.commentable.poster)
    end

  end


end