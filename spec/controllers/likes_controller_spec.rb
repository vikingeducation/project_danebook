
require 'rails_helper'

describe LikesController do 

  
 
    describe 'deleting a like' do
      let(:user){ create(:user) }
      let(:post){create(:post, user: user)}
      let(:like){ create(:like, user: user, likeable: post) }
      before :each do
        request.cookies["auth_token"] = user.auth_token

       like
      end

      it "Likes can be destroyed in the db" do 
        expect{delete :destroy, params: {id: post.id, type: "Post"} 
        }.to change(Like, :count).by(-1)
      end 
 
      it "Destroying a non-existant like warns the user" do
        process(:destroy, params: {id: 454, type: "Post"})
        expect(controller).to set_flash[:danger]
      end 

      it "It redirects you back" do
        process(:destroy, params: {id: post.id, type: "Post"})
        expect(controller).to redirect_to root_path
      end 
    end

    describe 'creating a like' do
      let(:user){ create(:user) }
      let(:post){create(:post, user: user)}
      let(:post2){create(:post, user: user)}
  
      before :each do
        request.cookies["auth_token"] = user.auth_token
      end

      it "Likes can be created in the db" do 
        expect{process(:create, params: {id: post.id, type: "Post"}) 
        }.to change(Like, :count).by(1)
      end  
 
      it "Liking yields a flash" do
        process(:create, params: {id: post2.id, type: "Post"})
        expect(controller).to set_flash[:success]
      end 

      it "It redirects you back" do
        process(:create, params: {id: post.id, type: "Post"})
        expect(controller).to redirect_to root_path
      end 
    end

end