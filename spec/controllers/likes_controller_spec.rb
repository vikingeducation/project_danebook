require 'rails_helper'

describe LikesController do

  let(:profile){ create(:profile, :with_attributes ) }
  let(:new_post){ create(:post) }
  let(:user){ create(:user, profile: profile, posts: [new_post]) }

  context "when visitor is not signed in" do

    it "likes#create will not create a new Like" do
      expect{post :create, params: {user_id: user.id, format: new_post.id}}.to change(Like, :count).by(0)
    end

  end

  context "when user is signed in" do

    before do
      request.cookies[:auth_token] = user.auth_token
    end

    it "likes#create will create a new Like" do
      expect{post :create, params: {user_id: user.id, format: new_post.id}}.to change(Like, :count).by(1)
    end

  end

end