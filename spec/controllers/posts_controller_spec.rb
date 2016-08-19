require 'rails_helper'

describe PostsController do
  let(:user) {create(:user)}
  let(:micro_post) {create(:post, user_id: user.id)}

  context "for signed in user" do

    before do
      request.cookies["auth_token"] = user.auth_token
    end

    describe "POST #create" do 
      it "creates a new post for a user" do 
        post :create, params: {post: attributes_for(:post),user_id: user.id}
        expect(response).to redirect_to user
      end
      it "changes the post count by 1" do 
        expect{post :create, params: {post: attributes_for(:post), user_id: user.id}}.to change(Post, :count).by(1)
      end
    end


    describe "DELETE #destroy" do 
      it "destroys the post" do
        micro_post
        expect{ delete :destroy, params: {user_id: user.id, id: micro_post.id}}.to change(Post, :count).by(-1)
      end

      it "redirects to the user" do
        delete :destroy, params: {user_id: user.id, :id => micro_post.id}
        expect(response).to redirect_to user
      end
    end

  end
end


