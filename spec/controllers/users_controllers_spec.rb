require 'rails_helper'

describe UsersController do

  let(:user) {create(:user)}

  describe "POST #create" do

    context "valid user" do
      it "properly creates user" do
        expect{ post :create, user: attributes_for(:user) }.to change(User, :count).by(1)
      end
    end

    context "invalid user" do
      it "throws an error" do
        expect { post :create, user: attributes_for(:user, password: "") }.to change(User, :count).by(0)
        expect(response).to render_template :new
      end
    end
  end



end