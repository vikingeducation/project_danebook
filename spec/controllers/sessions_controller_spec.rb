require 'rails_helper'

describe SessionsController do

  let(:profile){ create(:profile, :with_attributes ) }
  let(:user){ create(:user, :profile => profile) }

  it "will log in for correct user credentials" do
    post :create, params: {email: user.email, password: user.password}
    expect(response).to redirect_to user_timeline_path(user)
  end

  it "logging in with incorrect credentials redirects to login path" do
    post :create, params: {email: "incorrect@email.com", password: "incorrect"}
    expect(response).to redirect_to new_session_path
  end

end