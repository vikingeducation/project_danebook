require 'rails_helper'

describe SessionController do

  let(:user){ create(:user) }

  context "not logged in" do 
 
    describe 'logging in' do

      it "Sets user cookies" do
        process :create, params: {email: user.email , password: user.password}
        user.reload
        expect(response.cookies["auth_token"]).to eq(user.auth_token)
      end 

      it "Sets permanent user cookies on request" do
        #this doesn't test for permanency, merly for set, its near impossible to test for permanency. 
        process :create, params: {email: user.email , password: user.password, remember_me: 1}
        user.reload
        expect(response.cookies["auth_token"]).to eq(user.auth_token)
      end 


      it "Does not set user cookies if given bad data" do
        process :create, params: {email: "totallywrtong@yahoo.com" , password: user.password}
        user.reload
        expect(response.cookies["auth_token"]).to be nil
      end 

      it "Does set a flash message when given correct data" do
        process :create, params: {email: user.email , password: user.password}
        expect(controller).to set_flash[:success]
      end 

      it "Does set a flash message when given incorrect data" do
        process :create, params: {email: "totallywrtong@yahoo.com" , password: user.password}
        expect(controller).to set_flash[:danger]
      end 
    end

  end

   context "logged in" do 
 
    describe 'logging out' do
      before :each do
        request.cookies["auth_token"] = user.auth_token
      end
      it "Does set a flash message when logging out" do
        process :destroy
        expect(controller).to set_flash[:success]
      end

      it "Does destroy cookie when logging out" do
        process :destroy
        expect(response.cookies["auth_token"]).to be nil
      end 
    end

  end

end

