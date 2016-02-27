require 'rails_helper'
require 'pry'

describe ProfilesController do

  describe 'Authorized users' do

    let(:user){create(:user)}
    before :each do
      session[:user_id] = user.id 
    end

    describe 'GET #show' do
      it "has profile instance" do  
        get :show, :user_id => user.id
        expect(assigns(:profile)).to match(user.profile)
      end
    end
    describe 'GET #edit' do
    #Happy
      it "works for profile owner" do
        get :edit,  :user_id => user.id
        expect(response).to render_template :edit
      end
    #Bad
      it "does not work for others" do
        new_user = create :user 
        get :edit,  :user_id => new_user.id
        expect(response).to_not render_template :edit
      end

    end

    describe "PATCH #update" do
 
      it "updates the profile" do
        post :update, :user_id => user.id, profile: attributes_for(:profile, :college => "Stanford")
        user.profile.reload
        expect(user.profile.college).to eq("Stanford")

      end
      it "redirect to user's profile" do
        post :update, :user_id => user.id, profile: attributes_for(:profile) 
        expect(response).to redirect_to user_profile_path(:id => assigns(:profile))
      end

    end

  end

end