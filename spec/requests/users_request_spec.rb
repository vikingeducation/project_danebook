# # spec/requests/users_request_spec.rb
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

    it "creates a user" do
        expect{ post users_path, params: { :user => attributes_for(:user),
                                  :profile_attributes => attributes_for(:profile) } }.to change(User, :count).by(1)
                                  
    end

    it "Verify that an improper submission will not create a new User" do
      expect{
        get users_path, params: { user: attributes_for(:user) }
      }.to change(User, :count).by(0)
    end

    it "creates a flash message" do
      post users_path, params: { :user => attributes_for(:user) }
      expect(flash[:success]).to_not be_nil
    end
  end

  # describe 'GET #edit' do
  #   it "GET #edit works as normal" do
  #     get edit_user_path(user)
  #     expect(response).to be_success
  #   end
  # end

  # describe "Verify that authorized users can perform actions they should be able to like #update" do
  #   before { user }

  #   context "with valid attributes" do
  #     let(:updated_name){ "updated_foo" }

  #     it "actually updates the user" do
  #       put user_path(user), params: {
  #         :user => attributes_for(
  #           :user, 
  #           :name => updated_name)
  #       } 

  #       # This won't work properly if you don't reload!!!
  #       # The user in that case would be the same one
  #       # you set in the `let` method
  #       user.reload
  #       expect(user.name).to eq(updated_name)
  #     end
  #   end
  # end
end