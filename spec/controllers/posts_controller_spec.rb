require 'rails_helper'

include UserAuth

describe PostsController do
  describe 'Posts access' do

    let(:user) { create(:user) }
    let!(:my_post) { create(:post, author: user) }

    before do
      sign_me_in(user)
      allow(request).to receive(:referer).and_return(root_path)
    end


    describe 'POST #create' do
      it "creates a new post" do
        expect{ post :create, post: my_post.attributes }.to change(Post, :count).by(1)
      end

      it "doesn't create for users who are not logged in" do
        sign_me_out
        post :create, post: my_post.attributes
        expect(response).to redirect_to(login_path)
      end

      it "redirects to referrer" do
        post :create, post: my_post.attributes
        expect(response).to redirect_to(root_path)
      end

      it "flashes a success message" do
        post :create, post: my_post.attributes
        expect(flash[:success]).to eq("Post successfully submitted")
      end
    end

    describe 'DELETE #destroy' do
      it "deletes a post" do
        expect{ delete :destroy, id: my_post.id }.to change(Post, :count).by(-1)
      end

      it "doesn't allow anyone but the post owner to delete the post" do
        sign_me_in(create(:user))
        expect{ delete :destroy, id: my_post.id }.to change(Post, :count).by(0)
      end

      it "redirects to referrer" do
        delete :destroy, id: my_post.id
        expect(response).to redirect_to(root_path)
      end

      it "flashes a success message" do
        delete :destroy, id: my_post.id
        expect(flash[:alert]).to eq("Your post was deleted!")
      end
    end

  end
end