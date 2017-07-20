require 'rails_helper'
require 'pry'

describe 'SessionRequests' do

  let(:user){create(:user)}
  before { user }

  describe "POST #create" do

    it "proper submission creates a new user" do
      login_as(user)
      binding.pry
      expect(cookies[:user_id]).to eq(user.id)
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
