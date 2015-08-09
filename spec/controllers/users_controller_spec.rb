require 'rails_helper'

include UserAuth

describe UsersController do
  describe 'user access' do
    let(:user){ create(:user) }

    before do
      sign_me_in(user)
    end

    describe "GET #new" do

      it "works as normal for a new visitor" do
        sign_me_out
        get :new
        expect(response).to render_template :new
      end

      it "redirects a signed in user to their timeline" do
        get :new
        expect(response).to redirect_to(user_timeline_path(user))
      end
    end

    describe "GET #show" do

      it "renders a user's about page" do
        get :show, id: user.id
        expect(response).to render_template :show
      end

      it "doesn't render for a visitor" do
        sign_me_out
        get :show, id: user.id
        expect(response).to redirect_to login_path
        expect(flash[:error]).to eq("Please sign in or sign up to view this content")
      end

    end

    describe "POST #create" do

      it "redirects to the new user" do
        post :create, :user => attributes_for(:user)
        expect(response).to redirect_to user_path(assigns(:user))
      end

      it "actually creates the user" do
        expect{ post :create, user: attributes_for(:user) }.
        to change(User, :count).by(1)
      end
    end

    describe "GET #edit" do

      it "works as normal for the signed in user" do
        get :edit, :id => user.id
        expect(response).to render_template :edit
      end

      it "denies access for another user" do
        another_user = create(:user)
        get :edit, :id => another_user.id

        expect(response).to redirect_to root_url
      end
    end

    describe "PATCH #update" do

      context "with valid attributes" do

        let(:updated_email){ "new_email@email.com" }

        it "flashes the proper success message" do
          put :update,  :id => user.id,
                        :user => attributes_for(:user,
                                                email: updated_email)
          # binding.pry
          expect(flash[:success]).to eq("Your profile was updated")
          # expect(flash[:error]).to be nil
        end

        it "redirects to the updated user" do
          put :update,  :id => user.id,
                        :user => attributes_for(:user,
                                                email: updated_email)
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(user_path(user))
        end

        it "actually updates the user" do
          put :update,  :id => user.id,
                        :user => attributes_for(:user,
                                                email: updated_email)
          user.reload
          expect(user.email).to eq(updated_email)
        end
      end

      context "with invalid attributes" do

        it "flashes the proper error message" do
          put :update,  :id => user.id,
                        :user => attributes_for(:user,
                                                email: "fake_email",
                                                first_name: "",
                                                last_name: "")
          user.reload
          # binding.pry
          expect(flash[:error]).not_to be_empty
          expect(flash[:error]).to eq(assigns(:current_user).errors.full_messages)
          # expect(flash[:error]).to match_array(["First name is too short (minimum is 1 character)", "First name can't be blank", "Last name is too short (minimum is 1 character)", "Last name can't be blank", "Email is invalid"])
        end

        it "re-renders the edit page" do
          put :update,  :id => user.id,
                        :user => attributes_for(:user,
                                                email: "fake_email",
                                                first_name: "",
                                                last_name: "")
          expect(response).to render_template :edit
        end


      end
    end

    describe "DELETE #destroy" do

      it "destroys the user" do
        expect{
          delete :destroy, :id => user.id
        }.to change(User, :count).by(-1)
      end

      it "redirects to the root" do
        delete :destroy, :id => user.id
        expect(response).to redirect_to root_url
      end

      it "flashes the proper success message" do
        delete :destroy, :id => user.id
        expect(flash[:success]).to eq("Your account was successfully deleted from Danebook. Sad to see you leave!")
      end

      it "signs out the user after their account was deleted" do
        delete :destroy, :id => user.id
        expect(response.cookies["auth_token"]).to be nil
        expect(assigns(:current_user)).to be nil
      end

    end
  end
end