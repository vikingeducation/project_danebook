require 'rails_helper.rb'

describe UsersController do 

  describe "POST #create" do 

    specify "a new user can be created" do 
      expect{post :create, :user => attributes_for(:user)}.to change(User, :count).by(1)
    end

    specify "a user with no email can't be created" do 
      expect{post :create, user: attributes_for(:user, email: "")}.to change(User, :count).by(0)
    end

  end

end