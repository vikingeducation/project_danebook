require 'rails_helper'

describe UsersController do
  
  let(:user){build(:user)}


  context "new" do

    before { get :new }

    it "should render the new user page" do
      expect(response).to render_template :new 
    end

    it "should assign @user to be a new user" do
      expect(assigns(:user)).to be_a_new(User)
    end

  end  

  context 'create' do

    it "should create a new profile" do 
      expect { post :create, id: user.id,
                    user: attributes_for(:user)
              }.to change(User, :count).by(1)
    end

    it "should redirect_to edit profile path on successful creation" do
      post :create, id: user.id,
           user: attributes_for(:user)

      expect(response).to redirect_to edit_profile_path(assigns(:user).profile.id)
    end

    it "should render new on failure to save" do
      post :create, id: user.id, user: {bad: "params"}
      expect(response).to render_template :new
    end

  end

end