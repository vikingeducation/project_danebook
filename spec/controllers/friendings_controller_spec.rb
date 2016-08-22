require 'rails_helper'

describe FriendingsController do
  let(:user_one) { create(:user) }
  let(:user_two) { create(:user) }
  let(:friended_user) { user_one.friended_users << user_two }

  context "GET #index" do
    before do
      user_one
      get :index, user_id: user_one.id
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'sets an instance variable to all artists' do
      expect(assigns[:user]).to be_kind_of(User)
    end
  end

  # ----------------------------------------
  # POST #create
  # ----------------------------------------

  describe 'POST #create' do
    before do
      set_http_referer
    end

    let(:post_create_valid) do
      post :create,
        id: user_two.id
    end

    let(:post_create_invalid) do
      post :create,
        id: 0
    end


    context 'the user is NOT logged in' do
      it 'does not create the playlist selection' do
        expect { post_create_valid }.to change(Friending, :count).by(0)
      end

      it 'redirects to login' do
        post_create_valid
        expect(response).to redirect_to(login_path)
      end
    end


    context 'the user IS logged in' do
      context 'the data is valid' do
        before do
          create_session(user_one)
        end


        it 'creates the playlist selection' do
          expect { post_create_valid }.to change(Friending, :count).by(1)
        end


        it 'sets a success flash message' do
          post_create_valid
          expect(flash[:success]).to_not be_nil
        end


        it 'redirects back' do
          post_create_valid
          expect(response).to redirect_to(:back)
        end
      end


      context 'the data is invalid' do
        before do
          create_session(user_one)
        end

        it 'does not create the playlist selection' do
          expect { post_create_invalid }.to change(Friending, :count).by(0)
        end


        it 'sets an error flash' do
          post_create_invalid
          expect(flash[:error]).to_not be_nil
        end


        it 'redirects to back' do
          post_create_invalid
          expect(response).to redirect_to(:back)
        end
      end
    end
  end

  # ----------------------------------------
  # DELETE #destroy
  # ----------------------------------------

  describe 'DELETE #destroy' do
    let(:delete_destroy_valid) { delete :destroy, :id => user_two.id }
    let(:delete_destroy_invalid) { delete :destroy, :id => 0 }


    before do
      friended_user
      set_http_referer
    end


    context 'the user IS logged in' do
      before do
        create_session(user_one)
      end

      context 'when valid' do
        it 'destroys the playlist selection' do
          expect { delete_destroy_valid }.to change(Friending, :count).by(-1)
        end


        it 'sets a success flash' do
          delete_destroy_valid
          expect(flash[:success]).to_not be_nil
        end
      end


      context 'when invalid' do
        it 'does NOT destroy the playlist selection' do
          expect { delete_destroy_invalid }.to change(Friending, :count).by(0)
        end


        it 'sets a error flash' do
          delete_destroy_invalid
          expect(flash[:error]).to_not be_nil
        end
      end
    end


    context 'the user is NOT logged in' do
      it 'does NOT destroy the playlist selection' do
        expect { delete_destroy_valid }.to change(Friending, :count).by(0)
      end


      it 'redirects to login' do
        delete_destroy_valid
        expect(response).to redirect_to(login_path)
      end


      it 'sets an error flash' do
        delete_destroy_valid
        expect(flash[:error]).to_not be_nil
      end
    end
  end
end
