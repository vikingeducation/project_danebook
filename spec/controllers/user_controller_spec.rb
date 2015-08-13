require 'rails_helper'


  describe UsersController do
    let(:user){create(:user)}


    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end

    it "GET #new works as normal" do
      get :new
      expect(response).to render_template :new
    end

    # it 'Get #edit redirects to root' do
    #   get :edit
    #   expect(response).to redirect_to '/'
    # end

    context "Proper creation of a user" do
      it 'POST #create' do
        expect{post :create, user:  attributes_for(:user)}.to change(User, :count).by(1)
      end

      it 'POST #create' do
        expect{post :create, user:  { :name => "f", :email => "foo@bar.com", :password => "password"}}.to change(User, :count).by(0)
      end
      

      it "redirects to the new user" do
        post :create, :user => attributes_for(:user)
        expect(response).to redirect_to edit_user_profile_path(assigns(:user))
      end
  end

    
end
    

    # context "it destroys user if authorized" do
    #   before :each do
    #     session[:user_id] = user.id 
    #   end

    #   it "DELETE #destroy" do
    #     expect{
    #       delete :destroy, :id => user.id}
    #       .to change(User,:count).by(-1)
    #   end
      
    #   it "DELETE #destroy" do
    #     new_user = create :user 
    #     expect{
    #       delete :destroy, :id => new_user.id}
    #       .to change(User,:count).by(0)
    #   end
      
    # end

    


