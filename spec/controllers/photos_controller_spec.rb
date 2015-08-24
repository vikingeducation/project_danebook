require 'rails_helper'

describe PhotosController do


  describe 'GET#new' do

    let(:current_user) { create(:user) }

    before do
      request.cookies[:auth_token] = current_user.auth_token
    end

    it 'assigns @user' do
      get :new, :user_id => current_user
      expect(assigns(:user)).to eq(current_user)
    end

    it 'assigns @photo as a New Photo' do
      get :new, :user_id => current_user
      expect(assigns(:photo)).to be_a_new(Photo)
    end

  end


  describe 'POST#create' do

    #let(:current_user) { create(:user) }
    let(:new_photo) { create(:photo) }

    before do
        request.cookies[:auth_token] = new_photo.owner.auth_token
    end


    context 'with a valid upload' do

      before do
        post :create, :user_id => new_photo.owner.id,
                      :photo => new_photo.attributes
      end

      it { should use_before_action(:require_current_user) }

      it 'whitelists photo params' do
        should permit(:photo).for(:create)
      end

      it { should set_flash[:success].to('Photo successfully uploaded!') }

    end


  end


  describe 'GET#index' do

    let(:current_user) { create(:user) }

    before do
      request.cookies[:auth_token] = current_user.auth_token
    end


    it 'assigns @user' do
      get :index, :user_id => current_user
      expect(assigns(:user)).to eq(current_user)
    end

    it 'assigns @photos collection' do
      current_user.photos.create(attributes_for(:photo))
      get :index, :user_id => current_user
      expect(assigns(:photos)).to eq(current_user.photos)
    end


    context 'when user has <= 16 photos' do

      let(:photo_count) { 5 }

      it 'includes all photos in @photos' do
        photo_count.times { current_user.photos.create(attributes_for(:photo)) }
        get :index, :user_id => current_user
        expect(assigns(:photos).count).to eq(photo_count)
      end

    end


    context 'when user has > 16 photos' do

      let(:photo_count) { 17 }

      it 'limits @photos to 16' do
        photo_count.times { current_user.photos.create(attributes_for(:photo)) }
        get :index, :user_id => current_user
        expect(assigns(:photos).count).to eq(16)
      end


    end


  end


  describe 'GET#show' do

    let(:current_user) { create(:user) }
    let(:photo) { create(:photo) }

    before do
      request.cookies[:auth_token] = current_user.auth_token
    end


    it 'redirects non-friends to Photo index' do
      get :show, :user_id => photo.owner.id, :id => photo.id
      expect(response).to redirect_to(user_photos_path(photo.owner))
      should set_flash[:danger].to("You're not authorized to do this!")
    end


    context 'when Owner is friends with Viewer' do

      before do
        photo.owner.friended_users << current_user
      end


      it 'assigns @user' do
        get :show, :user_id => photo.owner.id, :id => photo.id
        expect(assigns(:user)).to eq(photo.owner)
      end

      it 'assigns @photo to view' do
        get :show, :user_id => photo.owner.id, :id => photo.id
        expect(assigns(:photo)).to eq(photo)
      end

      it 'allows friends to reach the Show page' do
        get :show, :user_id => photo.owner.id, :id => photo.id
        expect(response).to render_template(:show)
      end

    end

  end


  describe 'POST #destroy' do

    let(:photo) { create(:photo) }

    before do
      request.cookies[:auth_token] = photo.owner.auth_token
    end


    it 'assigns @photo' do
      delete :destroy, id: photo.id, user_id: photo.owner.id
      expect(assigns(:photo)).to eq(photo)
    end

    it 'assigns @user' do
      delete :destroy, id: photo.id, user_id: photo.owner.id
      expect(assigns(:user)).to eq(photo.owner)
    end

    it 'lets a user delete her photo' do
      delete :destroy, id: photo.id, user_id: photo.owner.id
      expect(flash[:success]).to eq("Photo successfully deleted!")
    end

    it 'redirects to the Post that the deleted Comment was under' do
      delete :destroy, id: photo.id, user_id: photo.owner.id
      expect(response).to redirect_to user_photos_path(photo.owner)
    end

    it 'prevents an unauthorized user from deleting' do
      request.cookies[:auth_token] = create(:user).auth_token
      delete :destroy, id: photo.id, user_id: photo.owner.id
      expect(flash[:danger]).to eq("You're not authorized to do this!")
    end

  end


end
