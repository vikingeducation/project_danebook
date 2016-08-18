require 'rails_helper'

describe UsersController do
  describe "user access" do
    let(:user){ create(:user) }
    let(:users){ [user, create(:user)]}

    before :each do
      request.cookies["auth_token"] = user.auth_token
    end

    context "Get #index" do
      it 'collects users into @users' do
          another_user = create(:user)

          get :index

          expect(assigns(:users)).to match_array [user, another_user]
      end
    end

    it 'GET #new works as normal' do
      # TODO: better to delete routes for new...etc if not being used
      get :new
      expect(response).to redirect_to login_path
    end

    context "POST #create" do
      it 'redirects to the new users show page' do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to user_path(assigns(:user))
      end
    end
  end
end
