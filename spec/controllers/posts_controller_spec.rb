require 'rails_helper'

describe PostsController do
  let(:user){ create(:user) }
  describe 'GET index' do
    it 'should assigns @posts' do
      result = []
      5.times { result << create(:post, author: user) }
      create(:post)

      get :index, user_id: user.id
      
      expect(assigns(:posts)).to eq(result)
    end
  end

  describe 'DELETE destroy' do
    let!(:post_item){ create(:post, author: user) }
    

    context "Signed-in User" do
      before do
        request.cookies["auth_token"] = user.auth_token
        request.env["HTTP_REFERER"] = root_path
      end

      it 'should destroy the user post' do
        
        expect{
          delete :destroy, user_id: user.id, id: post_item.id
        }.to change(Post, :count).by(-1)
      end

      it "should not be able to destroy another user post" do
        another_user = create(:user)
        another_post = create(:post, author: another_user)
        another_post
        expect{
          delete :destroy, user_id: another_user.id, id: another_post.id
        }.not_to change(Post, :count)
      end
    end

    context "Visitor" do
      it "should be redirected to root_path" do
        delete :destroy, user_id: user.id, id: post_item.id
        expect(response).to redirect_to root_path 
      end

      it "should not be able to destroy a post" do
        expect{
          delete :destroy, user_id: user.id, id: post_item.id
          }.not_to change(Post, :count)
      end
    end
  end
end