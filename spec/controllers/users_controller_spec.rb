require 'rails_helper'

describe UsersController do
  let(:user){create(:user)}
  let(:profile){user.create_profile(attributes_for(:profile))}

  context "for visitor" do
    describe 'GET #show' do
      it "redirects to sign_up page" do
        get :show, params: { id: user.id }
        expect(response).to render_template :show
      end
    end

    describe 'GET #new' do
      it "renders the :new template for user" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do

      context "with proper attributes" do 
        it "creates a new user" do 
          expect{
            
          post :create, user: attributes_for(:user)
          }.to change(User, :count).by(1)
        end

        it "redirects to new user" do 
          post :create, user: attributes_for(:user)
          expect(response).to redirect_to user_path(assigns(:user))
        end

        it "sets a flash message" do
          post :create, user: attributes_for(:user)
          assert_equal flash[:success], "User was saved in database"
        end
      end
    end
  end

  context "for logged in user" do
    before :each do 
      cookies[:auth_token] = user.auth_token
    end

    describe 'GET #show' do
      it "renders the :show template for user" do
        get :show, id: user.id
        expect(response).to render_template :show
      end
    end

    describe '#update'
  end

end