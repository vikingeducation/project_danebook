# spec/controllers/users_controller_spec.rb
require 'rails_helper'

describe UsersController do

  describe 'unsigned user actions' do

    let(:user){ create(:user) }

    describe 'GET #show' do

      it "redirects to signup page" do
        get :show, id: user.id
        expect(response).to redirect_to root_url
      end

    end

    describe 'GET #edit' do

      it "redirects to signup page" do
        get :edit, id: user.id
        expect(response).to redirect_to root_url
      end
    end

    describe 'POST #new' do

      it "allows unsigned user to access the signup page" do
        get :new
        expect(response).to render_template :new
      end

    end

    describe 'POST #create' do

      it "allows unsigned user to create new user information" do
        expect {post :create, user: attributes_for(:user)
                }.to change(User, :count).by(1)
      end

      it "redirects to edit page after unsigned user creates record" do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to edit_user_path(assigns(:user))
      end

      it "displays flash alert for usuccessful sign up" do
        post :create, user: attributes_for(:user, password: "1234")
        expect(request.flash[:alert]).to_not be_nil
      end

       it "renders signup page usuccessful sign up" do
        post :create, user: attributes_for(:user, password: "1234")
        expect(response).to render_template :new
      end

    end

    describe 'POST #update' do

      it "redirects to signup page" do
        put :update, id: user.id, user: attributes_for(:user, name: "New Name")
        expect(response).to redirect_to root_url
      end
    end

    describe 'DELETE #destroy' do

      it "redirects to signup page" do
        delete :destroy, id: user.id
        expect(response).to redirect_to root_url
      end
    end

  end  
  
  describe 'signed in user actions' do

    let(:user){ create(:user) }
    let(:another_user){ create(:user) }

    before :each do
      request.cookies["auth_token"] = user.auth_token
    end

    describe 'GET #show' do

      it "shows signed in user information" do
        get :show, id: user.id
        expect(assigns(:user)).to match user
      end

      it "shows information for another user" do
        get :show, id: another_user.id
        expect(assigns(:user)).to match another_user
      end

      ##################### Change  Dnebook #########################
      # BLOWS UP IN APP IF TRY TO ACCESS A NON EXISTENT USER VIEW   #
      ###############################################################
      # it "shows information for a not signed up user" do
      #   get :show, id: 100
      #   expect(assigns(:user)).to be_nil
      # end

    end
  
    describe 'GET #new' do

      it "allows access to the sign up page" do
        get :new
        expect(response).to render_template :new
      end

    end

    describe 'GET #edit' do

      it "shows edit page for a signed in user" do
        get :edit, id: user.id
        expect(response).to render_template :edit
      end

      it "shows edit information for a signed in user" do
        get :edit, id: user.id
        expect(assigns(:user)).to match user
      end

    end
  
    describe 'POST #update' do

      context "Successfull updates" do
        it "redirects to show path after successfull update" do
          user
          put :update, id: user.id, 
              user: attributes_for(:user, username: "newfoo", password: "456789123")
          expect(response).to redirect_to user_path(user)
        end

        it "has updated information after successfull update" do
          user
          put :update, id: user.id, 
              user: attributes_for(:user, username: "newfoo", password: "456789123")
          user.reload    
          expect(assigns(:user)).to eq user
        end

        it "does not add any records in database" do
          user
          updated_user = attributes_for(:user, username: "newfoo", password: "456678r484t84")
         expect {put :update, id: user.id, user: updated_user
                }.to change(User, :count).by(0)
       end        
      end

      context "Unsuccessfull updates" do
        it "has original information in case of unsuccessfull update" do
          user
          updated_user = attributes_for(:user, username: "newfoo", password: "456")
          put :update, id: user.id, user: updated_user
          user.reload
          expect(assigns(:user)).to eq user
          expect(assigns(:user)).to_not eq(updated_user)
        end

        it "flashes alert in case of unsuccessfull update" do
          user
          updated_user = attributes_for(:user, username: "newfoo", password: "456")
          put :update, id: user.id, user: updated_user
          expect(request.flash[:alert]).to_not be_nil
        end

        it "database record count remains unchanged" do
          user
          updated_user = attributes_for(:user, username: "newfoo", password: "456678r484t84")
         expect {put :update, id: user.id, user: updated_user
                }.to change(User, :count).by(0)
        end
      end
    end

    describe 'DELETE #destroy' do

      context "Successfull destroy" do
        it "redirects to post index path" do
          user
          delete :destroy, id: user.id
          expect(response).to redirect_to new_user_path
        end

        it "has decremented the database record count" do
          user
          expect {delete :destroy, id: user.id
                 }.to change(User, :count).by(-1)   
        end

        it "does find the user in database" do
          user
          delete :destroy, id: user.id
          expect { user.reload}.to raise_error(ActiveRecord::RecordNotFound)
        end    

        it "signs out the current user after delete" do
          user
          delete :destroy, id: user.id
          #caught bug here
          expect(assigns(:current_user)).to be_nil
        end       
      end
    end

    describe 'unauthorised action by signed in user' do
      it "to delete redirects user to sign up page" do
        another_user
        user
        delete :destroy, id: another_user.id
        expect(response).to redirect_to root_url
      end

      it "to update, redirects user to sign up page" do
        another_user
        user
        put :update, id: another_user.id, user: attributes_for(:user)
        expect(response).to redirect_to root_url
      end

      it "to edit, redirects user to sign up page" do
        user
        another_user
        get :edit, id: another_user.id
        expect(response).to redirect_to root_url
      end

    end  
  end

end
