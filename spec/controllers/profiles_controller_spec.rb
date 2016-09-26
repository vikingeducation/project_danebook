require 'rails_helper'
require 'pry'

describe ProfilesController do
  let(:user){create(:user)}
  let(:profile){create(:profile, user: user)}

  context 'for a visitor' do
  end

  context 'for self/current_user' do
    describe 'GET index' do
    end

    describe 'GET show' do
    end

    describe 'PATCH #update' do
    end
  end


  context 'for logged in as user' do

    before :each do 
      cookies[:auth_token] = user.auth_token
    end

    describe 'GET index' do
      it "renders the :index template for profile" do
        get :index, user_id: user.id
        expect(response).to render_template :index
      end
    end

    describe 'GET show' do
      it "renders the :index template for profile" do

        get :show, user_id: user.id
        expect(response).to render_template :show
      end
    end

    describe 'PATCH #update' do
      context "with valid attributes" do 
        let(:updated_year){1969}


        before :each do 
          profile 
          put :update, 
            user_id: user.id, 
            profile: attributes_for(
              :profile, 
              :year => updated_year)
          profile.reload
        end

        it "finds the specific secret" do
          expect(assigns(:profile)).to eq(profile)
        end

        it "redirects to the updated secret" do 
          expect(response).to redirect_to user_profiles_path(user)
        end

        it "actually updates the secret" do
          expect(user.profile.year).to eq(updated_year)
        end
      end

      context "with invalid attributes" do 
        it "stuff" do end
      end
    end
  end





end