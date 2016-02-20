require 'rails_helper.rb'

describe UsersController do

  describe "Visitor" do

    context "tries to make an account" do
      it "GET #new to visit signup page" do
        get :new
        expect(response).to render_template :new
      end

      it "POST #create with good attributes redirects to profile_path" do
        post :create, { user: attributes_for(:user) }
        expect(response).to redirect_to user_path(assigns(:user))
      end

      it "POST #create with bad attributes renders new page" do
        post :create, user: attributes_for(:user, first_name: "")
        expect(response).to render_template :new
      end
    end

    context "tries to visit a user's show page" do
      it "GET #show for valid user renders show" do
        user = create(:user)
        get :show, id: user.id
        expect(response).to render_template :show
      end

      it "GET #show for nonexistent user redirects to signup_path" do
        create(:user)
        get :show, id: 0
        expect(response).to redirect_to signup_path
      end
    end

  end

  describe "Logged In User" do

    let(:user) { create(:user) }

    before do
      create_session(user)
    end

    it "PATCH #update with good params" do
      patch :update, { id: user.id, user: attributes_for(:user) }
      expect(response).to redirect_to user_path(user)
    end

    it "PATCH #update with bad params" do
      patch :update, { id: user.id, user: attributes_for(:user) }
      expect(response).to redirect_to user_path(user)
    end
  end

end
