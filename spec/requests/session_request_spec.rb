require 'rails_helper'

describe 'SessionRequests' do

  let(:user){create(:user)}
  before do
    log_out
    user
    login_as(user)
  end

  describe "POST #create" do

    it "proper submission logs in new user, create a cookie" do
      expect(response.cookies["auth_token"]).to_not be_nil
    end

    it "creates a flash message" do
       expect(flash[:success]).to_not be_nil
     end
  end

  it "redirects after creating the new user" do
    expect(response).to have_http_status(:redirect)
  end

end
