require 'rails_helper'

describe PostsController do

  let(:user){ create(:user) }

  before do
    log_in(user)
  end

  describe "POST #create" do

    it "allows current user to create a valid post" do
      expect do
        post :create, params: { user_id: user.id, post: { content: "Hello" } }
      end.to change(user.posts, :count).by(1)
    end

    it "deos not allow a non-signed in user to create a post" do
      log_out

      expect do
        post :create, params: { user_id: user.id, post: { content: "Hello" } }
      end.to_not change(user.posts, :count)
    end

    it "redirects to the current users activities path" do
      post :create, params: { user_id: user.id, post: { content: "Hello" } }

      expect(controller).to redirect_to user_activities_path(user)
    end

  end

end
