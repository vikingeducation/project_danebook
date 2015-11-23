require 'rails_helper'

describe SessionsController do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}

  before do
    user
  end

  describe 'POST #create' do
    let(:post_create_session) do
      post :create, :email => user.email,
                    :password => user.password
    end

    let(:post_create_remember) do
      post :create, :email => user.email,
                    :password => user.password,
                    :remember_me => true
    end

    let(:post_create_invalid) do
      post :create, :email => 'foo@bar.com',
                    :password => 'foobar1234'
    end

    context 'the user authenticates' do
      it 'creates a new session' do
        post_create_session
        user.reload
        expect(cookies[:auth_token]).to eq(user.auth_token)
      end

      it 'signs the user in' do
        post_create_session
        expect(controller.current_user).to eq(user)
      end

      it 'sets the user to be remembered when desired' do
        expect(controller).to receive(:remember_sign_in).with(user)
        post_create_remember
      end

      it 'sets a success flash' do
        post_create_session
        expect(flash[:success]).to_not be_nil
      end
    end

    context 'the user does not authenticate' do
      before do
        post_create_invalid
      end

      it 'does not create a new session' do
        expect(cookies[:auth_token]).to be_nil
      end

      it 'does not sign the user in' do
        expect(controller.current_user).to be_nil
      end

      it 'sets an error flash' do
        expect(flash[:error]).to_not be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_destroy_session){delete :destroy}

    context 'the user is signed in' do
      before do
        login(user)
        delete_destroy_session
      end

      it 'signs the user out' do
        expect(controller.current_user).to be_nil
      end

      it 'destroys the session' do
        expect(cookies[:auth_token]).to be_nil
      end

      it 'sets a success flash' do
        expect(flash[:success]).to_not be_nil
      end
    end

    context 'the user is signed out' do
      before do
        delete_destroy_session
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to root_path
      end

      it 'sets an error flash' do
        expect(flash[:error]).to_not be_nil
      end
    end
  end
end











