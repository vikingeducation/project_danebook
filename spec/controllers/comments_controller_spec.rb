require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user){ create(:user) }
  let(:my_post){ create(:post, author: user) }
  before :each do
    sign_in(user)
  end
  describe "POST #create" do
    it "create a new comment" do
      expect{
        post :create, comment: attributes_for(:comment, user: user, commentable_id: my_post.id, commentable_type: 'Post')
      }.to change(Comment, :count).by(1)
    end
  end
end
