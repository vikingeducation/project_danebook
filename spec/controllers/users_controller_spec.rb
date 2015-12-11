require 'rails_helper'

describe UsersController do
  let(:female){create(:female)}
  let(:user){create(:user, :gender => female)}

  describe 'GET #show' do
    before do
      user
    end

    context 'the user is signed in' do
      before do
        login(user)
      end

      it 'sets an instance variable to the desired user' do
        get :show, :id => user.id
        expect(assigns(:user)).to eq(user)
      end

      it 'redirects when that user cannot be found' do
        get :show, :id => '1234'
        expect(response).to redirect_to root_path
      end

      it 'sets a flash message error when user is not found' do
        get :show, :id => '1234'
        expect(flash[:error]).to_not be_nil
      end
    end

    context 'the user is signed out' do
      before do
        get :show, :id => user.id
      end

      it 'redirects to signup path' do
        expect(response).to redirect_to signup_path
      end

      it 'sets an error flash' do
        expect(flash[:error]).to_not be_nil
      end
    end
  end

  describe 'GET #new' do
    context 'the user is signed in' do
      it 'redirects to the current user activity path' do
        login(user)
        get :new
        expect(response).to redirect_to user_activity_path(user)
      end
    end

    context 'the user is signed out' do
      before do
        get :new
      end

      it 'sets an instance variable to a user' do
        expect(assigns(:user)).to be_an_instance_of(user.class)
      end

      it 'set the instance to an unpersisted user' do
        expect(assigns(:user)).to_not be_persisted
      end

      it 'renders the new template' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    context 'the user is signed in' do
      before do
        login(user)
        get :edit, :id => user.id
      end

      it 'renders the edit template' do
        expect(response).to render_template :edit
      end

      it 'sets an instance variable to the desired user' do
        expect(assigns(:user)).to eq(user)
      end
    end

    context 'the user is signed out' do
      before do
        get :edit, :id => user.id
      end

      it 'redirects to the signup path' do
        expect(response).to redirect_to signup_path
      end

      it 'sets an error flash' do
        expect(flash[:error]).to_not be_nil
      end
    end
  end

  describe 'POST #create' do
    let(:post_create_user) do
      post :create, :user => attributes_for(
        :user,
        :gender_id => female.id
      )
    end

    let(:post_create_invalid) do
      post :create, :user => attributes_for(
        :user,
        :email => '1234',
        :password => ''
      )
    end

    context 'the user is signed in' do
      before do
        login(user)
        post_create_user
      end

      it 'redirects to the user activity path' do
        expect(response).to redirect_to user_activity_path(user)
      end

      it 'sets an error flash' do
        expect(flash[:error]).to_not be_nil
      end
    end

    context 'the user is signed out' do
      it 'creates a new user when valid' do
        expect {post_create_user}.to change(User, :count).by(1)
      end

      it 'signs that user in after creation' do
        post_create_user
        expect(controller.signed_in_user?).to eq(true)
      end

      it 'sets a success flash if created and signed in' do
        post_create_user 
        expect(flash[:success]).to_not be_nil
      end

      it 'sets an error flash if sign in failed' do
        post_create_invalid
        expect(flash[:error]).to_not be_nil
      end

      it 'does not create the user if invalid' do
        expect {post_create_invalid}.to change(User, :count).by(0)
      end
    end
  end

  describe 'PUT/PATCH #update' do
    let(:patch_update_user) do
      patch :update,  :id => user.id,
                      :user => attributes_for(
                        :user,
                        :gender_id => female.id,
                        :first_name => 'Updated'
                      )
    end

    let(:patch_update_invalid) do
      patch :update,  :id => user.id,
                      :user => attributes_for(
                        :user,
                        :email => '1234',
                        :password => ''
                      )
    end

    context 'the user is signed in' do
      before do
        login(user)
      end

      it 'updates the user when valid' do
        patch_update_user
        user.reload
        expect(user.first_name).to eq('Updated')
      end

      it 'sets a success flash when valid' do
        patch_update_user
        expect(flash[:success]).to_not be_nil
      end

      it 'does not update the user when invalid' do
        patch_update_invalid
        user.reload
        expect(user.email).to_not eq('1234')
      end

      it 'sets an error flash when invalid' do
        patch_update_invalid
        expect(flash[:error]).to_not be_nil
      end
    end

    context 'the user is signed out' do
      it 'redirects to the signup path' do
        patch_update_user
        expect(response).to redirect_to signup_path
      end

      it 'sets an error flash' do
        patch_update_user
        expect(flash[:error]).to_not be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_destroy_user){delete :destroy, :id => user.id}
    let(:delete_destroy_invalid){delete :destroy, :id => '1234'}

    context 'the user is signed in' do
      before do
        login(user)
      end

      it 'destroys the user when valid' do
        expect {delete_destroy_user}.to change(User, :count).by(-1)
      end

      it 'sets a success flash when valid' do
        delete_destroy_user
        expect(flash[:success]).to_not be_nil
      end

      it 'does not destroy the user when invalid' do
        expect {delete_destroy_invalid}.to change(User, :count).by(0)
      end

      it 'sets an error flash when invalid' do
        delete_destroy_invalid
        expect(flash[:error]).to_not be_nil
      end
    end

    context 'the user is signed out' do
      it 'redirects the user to signup path' do
        delete_destroy_user
        expect(response).to redirect_to signup_path
      end

      it 'sets an error flash' do
        delete_destroy_user
        expect(flash[:error]).to_not be_nil
      end
    end
  end
end












