require 'rails_helper'

describe LikesController do
   let(:user){ create(:user) }
   let(:new_post){ create(:post, user: user) }
   let(:comment){ create(:comment) }

   before do
    request.cookies["auth_token"] = user.auth_token
    new_post
    comment
   end

   describe "POST #create" do
      it "sets post variable when on a post" do
        post :create, params:{post_id: new_post.id}
        expect(assigns(:post)).to eq(new_post)
      end

      it "actually creates a like" do
        expect { post :create, params:{post_id: new_post.id} }.to change(Like, :count).by(1)
      end

      it "sets comment variable when on a comment" do
        post :create, params:{comment_id: comment.id}
        expect(assigns(:comment)).to eq(comment)
      end
   end

   describe "DELETE #destroy" do

    let(:like){ create(:like, :on_post) }
    let(:liked_post){ like.likeable }
    let(:comment_like){ create(:like, :on_comment) }
    let(:liked_comment){ comment_like.likeable }

    before do
      liked_post
    end

      it "sets post variable for a post" do
        delete :destroy, params:{post_id: liked_post.id, id: like.id }
        expect(assigns(:post)).to eq(liked_post)
      end

      it "actually deletes the like" do
        expect{ delete :destroy, params:{post_id: liked_post.id, id: like.id } }.to change(Like, :count).by(-1)
      end

      it "sets the comment variable for a comment" do
        delete :destroy, params:{comment_id: liked_comment.id, id: comment_like.id }
        expect(assigns(:comment)).to eq(liked_comment)
      end

   end
end