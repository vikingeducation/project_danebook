require 'rails_helper'

describe CommentsController do

  describe "POST #create" do

    let(:user){ create(:user) }

    before do
      log_in(user)
      user.posts.create(:content => "Post")
      @activity = user.activities.first
    end

    it "creates a comment if validation is sucessful" do
      expect do
        post :create, params: { activity_id: @activity.id, :comment => { :content => "comment" } }
      end.to change(@activity.comments, :count).by(1)
    end

    it "does not create a comment if validation is unsucessful"do
      expect do
        post :create, params: { activity_id: @activity.id, :comment => { :content => "" } }
      end.to_not change(@activity.comments, :count)
    end

    it "redirects to the authors page on succesful creation" do
      post :create, params: { activity_id: @activity.id, :comment => { :content => "comment" } }

      expect(controller).to redirect_to user_activities_path(user)
    end

    it "redirects to authors page on unsuccesful creation" do
      post :create, params: { activity_id: @activity.id, :comment => { :content => "comment" } }

      expect(controller).to redirect_to user_activities_path(user)
    end

    it "renders a flash message on unsuccesful creation" do
      post :create, params: { activity_id: @activity.id, :comment => { :content => "" } }

      expect(flash[:notice]).to_not be_empty
    end

  end

end
