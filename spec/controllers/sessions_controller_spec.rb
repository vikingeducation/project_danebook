require 'rails_helper.rb'

describe SessionsController do

  let(:user) { create(:user) }
  let(:profile) { create(:profile, user: user) }

  before do
    user
    profile
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  it "POST #create for valid user credentials" do
    post :create, email: user.email, password: user.password
    expect(response).to redirect_to user_path(user)
    expect(flash[:success]).to eq "You've successfully signed in"
  end

  it "POST #create for invalid user credentials" do
    post :create, email: user.email, password: "BADPASS"
    expect(response).to redirect_to "where_i_came_from"
  end

  it "DELETE #destroy" do
    create_session(user)
    delete :destroy
    expect(response).to redirect_to signup_path
    expect(flash[:success]).to eq "You've successfully signed out"
  end

end
