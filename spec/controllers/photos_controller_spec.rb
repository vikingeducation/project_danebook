require 'rails_helper'

describe PhotosController do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:friend){create(:user, :gender => male)}
  let(:friend_request){create(:friend_request, :initiator => friend, :approver => user)}
  let(:profile_photo){create(:profile_photo, :user => user)}
  let(:profile_photo_friend){create(:profile_photo, :user => friend)}

  describe 'GET #index' do
    before do
      profile_photo
    end

    context 'the user is signed in' do
      before do
        login(user)
        get :index, :user_id => user.id
      end

      it 'sets an instance variable to the user' do
        expect(assigns(:user)).to eq(user)
      end

      it 'sets an instance variable to the user photos' do
        expect(assigns(:photos)).to eq(user.photos)
      end

      it 'renders the index view' do
        expect(response).to render_template :index
      end
    end

    context 'the user is signed out' do
      before do
        get :index, :user_id => user.id
      end

      it 'redirects to signup' do
        expect(response).to redirect_to signup_path
      end

      it 'sets an error flash' do
        expect(flash[:error]).to_not be_nil
      end
    end
  end

  describe 'GET #show' do
    context 'the user is signed in' do
      context 'the user is friends with or is the photos user' do
        before do
          friend_request.accept
          login(user)
          get :show, :user_id => friend.id, :id => profile_photo_friend.id
        end

        it 'renders the show view' do
          expect(response).to render_template :show
        end

        it 'sets an instance variable to the photo' do
          expect(assigns(:photo)).to eq(profile_photo_friend)
        end
      end

      context 'the user is not friends with nor is the photos user' do
        before do
          login(user)
          get :show, :user_id => friend.id, :id => profile_photo_friend.id
        end

        it 'redirects to the photo user photos path' do
          expect(response).to redirect_to user_photos_path(friend)
        end

        it 'sets an error flash' do
          expect(flash[:error]).to_not be_nil
        end
      end
    end

    context 'the user is signed out' do
      before do
        get :show, :user_id => friend.id, :id => profile_photo_friend.id
      end

      it 'redirects to signup' do
        expect(response).to redirect_to signup_path
      end

      it 'sets an error flash' do
        expect(flash[:error]).to_not be_nil
      end
    end
  end

  describe 'POST #create' do
    let(:file){fixture_file_upload(FactoryHelper.other_photo, 'image/jpeg')}
    let(:post_create_photo) do
      post :create, :user_id => user.id,
                    :photo => attributes_for(
                      :photo,
                      :user_id => user.id,
                      :file => file
                    )
    end

    let(:post_create_invalid) do
      post :create, :user_id => user.id,
                    :photo => attributes_for(
                      :photo,
                      :user_id => friend.id,
                      :file => file
                    )
    end

    context 'the user is signed in' do
      before do
        login(user)
      end

      context 'the user is the user attempting to create the photo' do
        it 'creates the photo' do
          expect {post_create_photo}.to change(Photo, :count).by(1)
        end

        it 'sets a success flash' do
          post_create_photo
          expect(flash[:success]).to_not be_nil
        end
      end

      context 'the user is not the user attempting to create the photo' do
        it 'does not create the photo' do
          expect {post_create_invalid}.to change(Photo, :count).by(0)
        end

        it 'redirects to new user photo path' do
          post_create_invalid
          expect(response).to redirect_to new_user_photo_path
        end

        it 'sets an error flash' do
          post_create_invalid
          expect(flash[:error]).to_not be_nil
        end
      end
    end

    context 'the user is signed out' do
      before do
        post_create_photo
      end

      it 'redirects to signup' do
        expect(response).to redirect_to signup_path
      end

      it 'sets an error flash' do
        expect(flash[:error]).to_not be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_destroy_photo) do
      delete :destroy,  :user_id => user.id,
                        :id => profile_photo.id
    end

    let(:delete_destroy_invalid) do
      delete :destroy,  :user_id => friend.id,
                        :id => profile_photo.id
    end

    before do
      profile_photo
    end

    context 'the user is signed in' do
      before do
        login(user)
      end

      context 'the user is the user attempting to destroy the photo' do
        it 'destroys the photo' do
          expect {delete_destroy_photo}.to change(Photo, :count).by(-1)
        end

        it 'sets a success flash' do
          delete_destroy_photo
          expect(flash[:success]).to_not be_nil
        end
      end

      context 'the user is not the user attempting to destroy the photo' do
        it 'does not destroy the photo' do
          expect {delete_destroy_invalid}.to change(Photo, :count).by(0)
        end

        it 'sets an error flash' do
          delete_destroy_invalid
          expect(flash[:error]).to_not be_nil
        end
      end
    end

    context 'the user is signed out' do
      it 'redirects to signup' do
        delete_destroy_photo
        expect(response).to redirect_to signup_path
      end

      it 'sets an error flash' do
        delete_destroy_photo
        expect(flash[:error]).to_not be_nil
      end
    end
  end
end








