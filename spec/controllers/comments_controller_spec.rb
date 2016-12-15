
require 'rails_helper'

describe CommentsController do

  let(:user){ create(:user) }
  let(:post){create(:post, user: user)}
  let(:post2){create(:post, user: user)}
  let(:user_comment){ create(:comment, user: user, commentable: post) }
 
    describe 'deleting a comment' do
      before :each do
        request.cookies["auth_token"] = user.auth_token

        user_comment
      end

      it "Comments can be destroyed in the db" do 
        expect{delete :destroy, params: {id: post.id, type: "Post"} 
        }.to change(Comment, :count)
      end 
 
      it "Destroying a non-existant comment warns the user" do
        process(:destroy, params: {id: 454, type: "Post"})
        expect(controller).to set_flash[:danger]
      end 

      it "Destroying a existant comment notifies you" do
        process(:destroy, params: {id: post.id, type: "Post"})
        expect(controller).to set_flash[:success]
      end 

      it "It redirects you back" do
        process(:destroy, params: {id: post.id, type: "Post"})
        expect(controller).to redirect_to root_path
      end 
    end
    describe 'creating a comment' do
       before :each do
        request.cookies["auth_token"] = user.auth_token
      end

      it "comments can be created in the db" do 
        expect{process(:create, params: {id: post.id, type: "Post", comment: {body: "balalalalaala"}}) 
        }.to change(Comment, :count).by(1)
      end  
 
      it "comments yields a flash" do
        process(:create, params: {id: post2.id, type: "Post", comment: {body: "balalalalaala"}})
        expect(controller).to set_flash[:success]
      end 

      it "It redirects you back" do
        process(:create, params: {id: post.id, type: "Post", comment: {body: "balalalalaala"}})
        expect(controller).to redirect_to root_path
      end 
    end
end