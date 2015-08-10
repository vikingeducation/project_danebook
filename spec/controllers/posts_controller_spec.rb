require 'rails_helper'

include UserAuth

describe PostsController do
  describe 'Posts access' do

    let(:user) { create(:user) }
    let!(:my_post) { create(:post) }

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
        # binding.pry
        expect{ post :create, post: my_post.attributes }.to raise_error(NoMethodError) #No current user, so no posts for current user
      end
    end

  end
end