require 'rails_helper'

describe UsersController do
  describe 'user access' do
    let(:user) { create(:user) }
    before do
      request.cookies["auth_token"] = user.auth_token
    end
    
    describe 'GET #index' do
      it "collects users into @users" do
        another_user = create(:user)
        get :index
        expect(assigns(:users)).to match_array [user,another_user]
      end

      it "renders the :index template" do
        get :index

        # We can check which view template is being rendered
        expect(response).to render_template :index
      end
    end

    it "GET #new works as normal" do
      get :new
      expect(response).to render_template :new
    end

    describe "POST #create" do
      it "redirects to the edit user's profile" do

        # Send in the attributes of a user (from our factory)
        #   as if we'd submitted them in a `form_for` form
        post :create, :user => attributes_for(:user, 
                                              :profile_attributes => {
                                                "birthday_year(1i)" => "1950", 
                                                "birthday_year(2i)" => "1", 
                                                "birthday_year(3i)" => "1" })

        # Now expect a redirect instead of a render
        # AND we'll utilize our newly-assigned instance
        # variable to make sure we get to the right user
        expect(response).to redirect_to edit_profile_path(assigns(:user).profile)
      end

      it "actually creates the user" do
        expect{
          post :create, user: attributes_for(:user,
                                             :profile_attributes => {
                                                "birthday_year(1i)" => "1950", 
                                                "birthday_year(2i)" => "1", 
                                                "birthday_year(3i)" => "1" })
        }.to change(User, :count).by(1)
      end

    end
  end
end