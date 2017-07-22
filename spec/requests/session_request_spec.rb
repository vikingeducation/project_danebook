require 'rails_helper'
require 'pry'

describe 'SessionRequests' do

  let(:user){create(:user)}
  before do
    user
    login_as(user)
  end

  describe "POST #create" do

    it "proper submission loggs in new user, create a cookie" do
      expect(flash[:success]).to_not be_nil
      expect(response.cookies["auth_token"]).to_not be_nil
    end

  end


end
#........==========
# user - create,
# comments - create, delete
# likes - create, delete
# posts - create, delete
# profiles -  update
# session - authentication tests
