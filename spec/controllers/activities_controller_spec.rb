require 'rails_helper'

describe ActivitiesController do

  describe "GET #index" do

    let(:user) { create(:user) }

    before do
      log_in(user)
    end

    it "set all wall activites to an instance variable" do
      user.posts.create(content: "Hello")
      user.comments_made.create(content: "Comment")

      get :index, params: { user_id: user.id }

      expect(assigns(:activities)).to eq(user.get_wall_activities)
    end

    it "sets a new post to an instance variable" do
      get :index, params: { user_id: user.id }

      expect(assigns(:post)).to be_a(Post)
    end

    it "sets a new comment to an instance variable" do
      get :index, params: { user_id: user.id }

      expect(assigns(:comment)).to be_a(Comment)
    end

  end

  describe 'DELETE #destroy' do

    let(:user) { create(:user) }

    before do
      user.posts.create(:content => "post")
      log_in(user)
    end

    it "destroys a given activity" do
      expect do
        delete :destroy, params: { user_id: user.id, id: user.activities.first.id }
      end.to change(user.activities, :count).by(-1)
    end

    it "creates a flash notice" do
      delete :destroy, params: { user_id: user.id, id: user.activities.first.id }

      expect(flash[:notice]).to_not be_empty
    end

    it "redirects to the user who posted post if it type of post" do
      delete :destroy, params: { user_id: user.id, id: user.activities.first.id }

      expect(controller).to redirect_to user_activities_path(user)
    end

    it "redirects to the user who owns post if it type of comment" do
      second_user = create(:user)
      log_in(second_user)
      comment = user.activities.first.comments.create(content: "Hello")
      Activity.create(author_id: second_user.id,
      postable_type: "Comment", postable_id: comment.id)

      delete :destroy, params: { user_id: second_user.id, id: second_user.activities.first.id }

      expect(controller).to redirect_to user_activities_path(user)
    end

    it "does not allow another user to destoy an activity" do
      second_user = create(:user)

      expect do
        delete :destroy, params: { user_id: second_user.id, id: user.activities.first.id }
      end.to_not change(user.activities, :count)
    end

  end

end
