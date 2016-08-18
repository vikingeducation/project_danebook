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

    it 'GET #new goes to login/signup page' do
      get :new
      expect(response).to redirect_to login_path
    end

    context "POST #create when user is not logged in" do
      before do
        request.cookies["auth_token"] = nil
      end
      it 'redirects to the new users show page' do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to user_path(assigns(:user))
      end

      it 'persists the new user' do
        expect {post :create, user: attributes_for(:user)}.to change(User, :count).by(1)
      end

      it 'creats a profile for the user before saving' do
        post :create, user: attributes_for(:user)
        expect(assigns(:user).profile).to_not be_nil
      end
    end

    context "GET #show works as normal" do
      before { user }

      it 'shows show page when visiting that user ids page' do
        # post = create(:post)
        # posts = [post, create(:post)]
        get :show, id: user.id
        expect(response).to have_content user.first_name
      end
    end
  end
end
