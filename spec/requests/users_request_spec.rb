# spec/requests/users_request_spec.rb
require 'rails_helper'

describe 'UsersRequests' do
  let(:user){ create(:user) }
  let(:profile){ create(:profile,:user => user)}

  before :each do 
    user
    profile
    post sessions_path, params: { email: user.email, password: "foobar"}
  end

  describe 'Users' do
    it "Verify that a proper submission will create a new User" do
      get user_path(user)
      expect(response).to be_success
    end

    it "GET #edit path works" do
      get edit_user_path(user)
      expect(response).to be_success
    end

    it  "creates a new user" do
      profile_attributes = attributes_for(:profile)
      user_hash = attributes_for(:user)
      user_hash[:profile_attributes] = profile_attributes

      expect{ 
        post users_path, params: {
        :user => user_hash
        } 
      }.to change(User, :count).by(1)
    end
 
    it "sets up auth token" do
      post users_path, params: { :user => attributes_for(:user)}
      expect(response.cookies["auth_token"]).to_not be_nil
    end
 
 

    it "redirects once the user is created" do
      post users_path, params: { :user => attributes_for(:user) }
      expect(response).to have_http_status(:redirect)
    end


    it "creates a flash message" do
      post users_path, params: { :user => attributes_for(:user) }
      expect(flash[:success]).to_not be_nil
    end

    describe "Verify that authorized users can perform actions like #update" do

      let(:updated_name){ "updated_foo" }

      it "actually updates the user" do

        profile_attributes = attributes_for(:profile)
        profile_attributes[:firstname] = updated_name

        user_hash = attributes_for(:user)
        user_hash[:profile_attributes] = profile_attributes


        put user_path(user), params: {
          :user => user_hash
        } 
        user.reload
        expect(user.profile.firstname).to eq(updated_name)
      end
    end
  end
end

describe 'PostRequests' do
  describe 'Posts' do
    let(:user){ create(:user) }
    let(:profile){ create(:profile,:user => user)}
    let(:post_new){ create(:post,:user => user)}

    before :each do 
      user
      profile
      post_new
      post sessions_path, params: { :email => user.email, :password => user.password }
    end

    it "creates a post" do
      expect{ post user_posts_path(user), params: { :post => { :body => "New body", :user_id => user.id } } }.to change(Post, :count).by(1)
    end

    it "destroys the post" do
      expect{
        delete user_post_path(user, post_new)
      }.to change(Post, :count).by(-1)
    end
  end
end