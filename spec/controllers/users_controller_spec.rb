require 'rails_helper'

describe UsersController do
  let(:user){ create(:user) }

  before :each do
    request.cookies["auth_token"] = user.auth_token
  end

  describe "GET index" do

    it 'collects users into @users' do
      another_user = create(:user)
      get :index

      expect(assigns(:users)).to match_array [user, another_user]
    end

    it "render the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'POST user' do
    it "create a user if valid attributes" do
      expect{
        post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
    end

    it "doesn't create a user if missing email" do
      expect{
        post :create, user: attributes_for(:user, email: "")
      }.not_to change(User, :count)
    end

    it "render :new template if missing email" do
      post :create, user: attributes_for(:user, email: "")
      expect(response).to render_template :new
    end
  end

  describe "GET edit" do

    context 'signed-in user' do

      it "should render the edit page" do
        get :edit, id: user.id
        expect(response).to render_template :edit
      end

      it "redirect to the root_path if another user's edit page" do
        another_user = create(:user)
        get :edit, id: another_user.id
        expect(response).to redirect_to root_path
      end
    end

    context 'visitor' do
      it "redirect to the root path" do
        request.cookies["auth_token"] = nil
        get :edit, id: user.id
        expect(response).to redirect_to root_path
      end
    end

  end

  describe 'PUT update' do

  end

end