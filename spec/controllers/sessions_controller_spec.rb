require 'rails_helper'

describe SessionsController do
  let(:profile) { create(:profile) }
  let(:user) { create(:user, profile: profile) }

  context "logging in" do
    before do
    user.save!
    get :create, { email: user.email, password: user.password }
    # this regenerates the auth_token
    end
    it "should login and redirect to root" do
      expect(response).to redirect_to root_path
      expect(cookies[:auth_token]).to be_a(String)
      expect(signed_in_user?).to be true
    end
    it { should set_flash[:success]}


    context "logging out" do
      before { delete :destroy }
      it "should logout and redirect to root" do
        expect(response).to redirect_to root_path
        expect(cookies[:auth_token]).to be nil
      end
      it { should set_flash[:success]}
    end
  end


end
