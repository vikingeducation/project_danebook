require 'rails_helper'

describe UsersController do

  let(:user) { create(:user) }
  let(:profile) { create(:profile, user: user) }

  before :each do
    profile
    cookies[:auth_token] = user.auth_token
  end

  describe "GET #new" do

    it "builds a profile for the user" do
      get :new
      expect(assigns(:user)).to respond_to(:profile)
    end

    it "renders the new page" do
      get :new
      expect(response).to render_template :new
    end

  end

  describe "POST #create" do

    context "valid parameters" do

      it "redirects to a new user" do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to assigns(:user)
      end

      it "creates a new user" do
        expect { post :create, user: attributes_for(:user) }.to change { User.count }.by(1)
      end
    end

    context "invalid parameters" do

      it "renders new with invalid params" do
        post :create, user: attributes_for(:user, email: "")
        expect(response).to render_template :new
      end

      it "does not create a user with invalid params" do
        expect { post :create, user: attributes_for(:user, email: "") }.to change { User.count }.by(0)
      end

    end

    it "sets flash message" do
      post :create, user: attributes_for(:user)
      expect(flash[:success]).to_not be nil
    end

    it "signs in user" do
      post :create, user: attributes_for(:user)
      # expect(assigns :user).to eq assigns :current_user
      expect(controller.send(:signed_in_user?)).to eq true
    end
  end

  describe "PUT #update" do

    it "redirects user to show page" do
      put :update, id: user.id, user: attributes_for( :user, first_name: "howie")
      expect(response).to redirect_to user
    end

    it "updates user attributes" do
      put :update, id: user.id, user: attributes_for( :user, first_name: "howie")
      expect(assigns :current_user).to eq user.reload
    end

    it "does not allow unauthorized user" do
      another_user = create(:user)
      put :update, id: another_user.id, user: attributes_for( :user, first_name: "howie")
      expect(flash[:error]).to eq "You're not authorized to view this"
      expect(response).to redirect_to user
    end
  end

  describe "GET #edit" do

    it "renders edit template" do
      get :edit, id: user.id
      expect(response).to render_template :edit
    end

    it "sets a current_user variable" do
      get :edit, id: user.id
      expect(assigns(:current_user)).to eq user
    end
  end

  describe "DELETE #destroy" do

    it "deletes the user" do
      expect { delete :destroy, id: user.id }.to change { User.count }.by(-1)
    end

    it "redirects to the root path" do
      delete :destroy, id: user.id
      expect(response).to redirect_to root_path
    end
  end


end