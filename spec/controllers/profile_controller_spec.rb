require 'rails_helper'


  describe ProfilesController do
    let(:user){create(:user)}

    describe 'GET #show' do
      it "renders the :show template" do
        get :show, :user_id => user.id
        expect(response).to render_template :show
      end

      it "shows you the the right users page" 
    end

    describe "GET #edit" do
      let(:user){create(:user)}
  
      it "for this user works as normal" do
        current_user = create(:user)
        current_user.profile create(:profile)
        get :edit, :user_id => current_user.id
        expect(response).to render_template :edit
      end

      # it "for another user denies access" do
      #   another_user = create(:user)
      #   get :edit, :id => another_user.id
      #   expect(response).to redirect_to root_url
      # end
    end

  end
