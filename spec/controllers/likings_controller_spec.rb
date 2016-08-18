require 'rails_helper'

describe LikingsController do

  let(:user){ create(:user) }

  before do
    user.posts.create(:content => "Post")
    user.comments_made.create(:content => "Post")
    log_in(user)
    request.env['HTTP_REFERER'] = 'http://test.com/sessions/new'
  end

  describe "POST #create" do

    it "creates a new liking" do
      expect do
        post :create, params: { activity_id: user.activities.first.id }
      end.to change(user.liked_things, :count).by(1)
    end

    it "does not allow creation if not logged in a new liking" do
      log_out

      expect do
        post :create, params: { activity_id: user.activities.first.id }
      end.to_not change(user.liked_things, :count)
    end

    it "redirects to referer on succesful creation" do
      post :create, params: { activity_id: user.activities.first.id }

      expect(controller).to redirect_to('http://test.com/sessions/new')
    end

  end

  describe "DELETE #destroy" do

    before do
      user.activities.first.likes.create(user_id: user.id)
    end

    it "allows a user to destroy a like" do
      expect do
        delete :destroy, params: { id: user.liked_things.first.id }
      end.to change(user.liked_things, :count).by(-1)
    end

    it "does not allows a user to destroy another users like" do
      second_user = create(:user)

      log_in(second_user)

      expect do
        delete :destroy, params: { id: user.liked_things.first.id }
      end.to_not change(user.liked_things, :count)
    end

    it "redirects to referer" do
      delete :destroy, params: { id: user.liked_things.first.id }

      expect(controller).to redirect_to('http://test.com/sessions/new')
    end

    it "sets flash on unauthorized attempt" do
      second_user = create(:user)

      log_in(second_user)
      delete :destroy, params: { id: user.liked_things.first.id }

      expect(flash[:alert]).to_not be_empty
    end

  end

end
