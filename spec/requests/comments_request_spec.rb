require 'rails_helper'
require 'pry'

describe 'CommentsRequests' do

    let(:user){create(:user)}
    let(:profile){create(:profile, :user_id => user.id)}
    let(:old_post){create(:post, :user_id => user.id)}

    before do
      user
      profile
      login_as(user)
    end
 
    describe "POST #create" do
      it "creates comment with successfull flash messsage" do
        post comments_path, params: { :comment => {:commentable_id => old_post.id, :commentable_type => "#{Post.name}", :body => "Hey, it is my new comment" } }
        expect(flash[:success]).to_not be_nil
      end

      it "actually creates the comment" do
        expect{ post comments_path, params: { :comment => {:commentable_id => old_post.id, :commentable_type => "#{Post.name}", :body => "Hey, it is my new comment" } } }.to change(Comment, :count).by(1)
      end
    end

    describe "DELETE #destroy" do

      let(:new_post){create(:post, :user_id => user.id)}

      before do
        login_as(user)
        old_post
        old_post.comments.create(attributes_for(:comment, :user_id => user.id))
        new_post.comments.create(attributes_for(:comment, :user_id => user.id))
        new_post
      end

      it "deletes comment" do
        expect{ delete comments_path, params: {:id => old_post.comments.last.id, :user_id => user.id } }.to change(Comment, :count).by(-1)
      end

      it "destroying post, will destroy the comment also" do
        expect{ delete user_post_path(user, new_post) }.to change(Comment, :count).by(-1)
      end
    end

end
