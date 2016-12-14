require 'rails_helper'

describe PostsController do

  let(:user){ create(:user) }
  let(:user_post){ create(:post, user: user) }
 
    describe 'deleting a post' do
      before :each do
        request.cookies["auth_token"] = user.auth_token
        user_post
      end

      it "Post's can be destroyed in the db" do
        expect{process(:destroy, params: {user_id: user.id, id: user_post.id}) }.to change(Post, :count)
      end 

      it "Destroying a non-existant post raises an error" do
        expect{process(:destroy, params: {user_id: 343, id: 454}) }.to raise_error(ActiveRecord::RecordNotFound)
      end 
    end

end

