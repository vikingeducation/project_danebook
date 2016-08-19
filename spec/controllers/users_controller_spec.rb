require 'rails_helper'

describe UsersController do
  let(:user){ create(:user) }

  context "Logged In" do
    before do
      cookies["auth_token"] = user.auth_token
    end

    describe "GET #show" do
      it "can load a page" do
        get :show, params: { id: user.id }
        expect(response.status).to eql(200)
      end
    end

    describe "PATCH #update" do
      it "will update a profile with valid attributes" do
        patch :update, params: { id: user.id, user: attributes_for(:user, first_name: "New Guy") }
        user.reload

        expect(user.first_name).to eql("New Guy")
      end

      it "redirects to the about page" do
        patch :update, params: { id: user.id, user: attributes_for(:user, first_name: "New Guy") }

        expect(response.status).to eql(302)
      end

      it "won't update a profile with invalid attributes" do
        name = user.first_name
        patch :update, params: { id: user.id, user: attributes_for(:user, first_name: nil) }
        user.reload

        expect(user.first_name).to eql(name)
      end

      it "won't update someone else's profile" do
        user2 = create(:user)
        name = user2.first_name

        patch :update, params: { id: user2.id, user: attributes_for(:user, first_name: "New Name") }
        user.reload

        expect(user2.first_name).to eql(name)
      end

    end

    describe "GET #new" do
      it "redirects to the user page" do
        get :new
        expect(response).to redirect_to user_path(user)
      end
    end

    describe "GET #edit" do
      it "renders a page" do
        get :edit, params: { id: user.id }
        expect(response.status).to eql(200)
      end
    end

    describe "GET #about" do
      it "renders a page" do
        get :about, params: { id: user.id }
        expect(response.status).to eql(200)
      end
    end
  end

  context "Logged Out" do
    describe "POST #create" do
      it "creates a user with valid attributes" do
        expect {
          post :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it "redirects a valid user" do
        post :create, params: { user: attributes_for(:user) }

        expect(response.status).to eql(302)
      end
    end

    describe "GET #show" do
      it "redirects to root" do
        get :show, params: { id: user.id }
        expect(response).to redirect_to root_path
      end
    end

    describe "GET #edit" do
      it "redirects to root" do
        get :edit, params: { id: user.id }
        expect(response).to redirect_to root_path
      end
    end

    describe "GET #about" do
      it "redirects to root" do
        get :about, params: { id: user.id }
        expect(response).to redirect_to root_path
      end
    end

    describe "POST #update" do
      it "won't update a user" do
        name = user.first_name
        patch :update, params: { id: user.id, user: attributes_for(:user, first_name: "New Name") }
        user.reload

        expect(user.first_name).to eql(name)
      end

      it "redirects" do
        patch :create, params: { user: attributes_for(:user, first_name: "New Name") }
        expect(response.status).to eql(302)
      end
    end
  end

end
