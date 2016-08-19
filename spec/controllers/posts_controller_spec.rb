require 'rails_helper'

describe PostsController do
  let(:user) { create(:user) }
  let(:user_post) { create(:post, author_id: user.id) }

  context "Logged In" do
    before do
      cookies["auth_token"] = user.auth_token
    end

    describe "POST #create" do
      it "creates a new post from valid attributes" do
        expect {
          post :create, params: { user_id: user.id, post: attributes_for(:post) }
        }.to change(Post, :count).by(1)
      end

      it "won't create a new post from invalid attributes" do
        expect {
          post :create, params: { user_id: user.id, post: attributes_for(:post, text: nil) }
        }.to_not change(Post, :count)
      end

      it "creates a flash for invalid attributes" do
        post :create, params: { user_id: user.id, post: attributes_for(:post, text: nil) }

        expect(flash[:danger]).to_not be_nil
      end

      it "won't create a post for another user" do
        new_user = create(:user)
        count = new_user.posts.count

        post :create, params: { user_id: new_user.id, post: attributes_for(:post) }

        expect(new_user.posts.count).to eql(count)
      end
    end

    describe "DELETE #destroy" do
      it "deletes a user's posts" do
        user_post
        expect {
          delete :destroy, params: { id: user_post.id }
        }.to change(Post, :count).by(-1)
      end

      it "creates a flash for a post that doesn't exist" do
        delete :destroy, params: { id: 9999 }

        expect(flash[:danger]).to_not be_nil
      end

      it "won't raise an error for a post that doesn't exist" do
        expect {
          delete :destroy, params: { id: 9999 }
        }.to_not raise_error
      end

      it "won't destroy the post of another user" do
        new_post = create(:post)

        expect {
          delete :destroy, params: { id: new_post.id }
        }.to_not change(Post, :count)
      end
    end
  end

  context "Logged Out" do
    describe "POST #create" do
      it "won't create a post" do
        expect {
          post :create, params: { user_id: user.id, post: attributes_for(:post) }
        }.to_not change(Post, :count)
      end

      it "creates a flash about logging in" do
        post :create, params: { user_id: user.id, post: attributes_for(:post) }

        expect(flash[:danger]).to_not be_nil
      end
    end

    describe "DELETE #destroy" do
      before { user_post }

      it "won't delete a post" do
        expect {
          delete :destroy, params: { id: user_post.id }
        }.to_not change(Post, :count)
      end

      it "creates a flash about logging in" do
        delete :destroy, params: { id: user_post.id }

        expect(flash[:danger]).to_not be_nil
      end
    end
  end

end
