require 'rails_helper'

describe CommentsController do

  let(:profile){ create(:profile, :with_attributes ) }
  let(:new_post){ create(:post) }
  let(:user){ create(:user, profile: profile, posts: [new_post]) }

  context "when visitor is not signed in" do

    it "comments#create will not create a new Comment" do
      expect{post :create, params: {user_id: user.id, comment: {body: "Text", post_id: new_post.id}}}.to change(Comment, :count).by(0)
    end

  end

  context "when user is signed in" do

    before do
      request.cookies[:auth_token] = user.auth_token
    end

    it "comments#create will create a new Comment" do
      expect{post :create, params: {user_id: user.id, comment: {body: "Text", post_id: new_post.id}}}.to change(Comment, :count).by(1)
    end

  end

end