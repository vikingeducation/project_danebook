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

      it "Does not set user cookies if given bad data" do
        process :create, params: {email: "totallywrtong@yahoo.com" , password: user.password}
        user.reload
        expect(response.cookies["auth_token"]).to be nil
      end 

    end

  end

end

#what do we wanna test?
#loging in sets a cookie
#logging out destroys that cookie
#logging in with incorrect parameters flash error
#logging out renders a flash

#destroying a post destroys it in the db
#destroying another users post doesn't work
#destroying a comment works
#destroying another users comment doesn't work
#destroying a like works
#destroying another users like doesn't work
#updating profile renders a flash
#updating another users profile fails