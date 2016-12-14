#destroying a like works
#destroying another users like doesn't work
#updating profile renders a flash
#updating another users profile fails

require 'rails_helper'

describe LikesController do

  let(:user){ create(:user) }
  let(:post){create(:post, user: user)}
  let(:like){ create(:like, user: user, likeable: post) }
 
    describe 'deleting a comment' do
      before :each do
        request.cookies["auth_token"] = user.auth_token

       like
      end

      it "Likes can be destroyed in the db" do 
        expect{delete :destroy, params: {id: post.id, type: "Post"} 
        }.to change(Like, :count)
      end 
 
      it "Destroying a non-existant like warns the user" do
        process(:destroy, params: {id: 454, type: "Post"})
        expect(controller).to set_flash[:danger]
      end 

      # it "Destroying a existant comment notifies you" do
      #   process(:destroy, params: {id: post.id, type: "Post"})
      #   expect(controller).to set_flash[:success]
      # end 
    end

end