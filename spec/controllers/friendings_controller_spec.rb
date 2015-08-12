require 'rails_helper'

describe FriendingsController do

  before do
    allow(controller).to receive(:store_referer) { session[:referer] = root_path }
  end

  let(:user) { create(:user) }
  let(:target) { create(:user) }

  it 'should redirect the user if not logged in' do
    post :create, id: 1
    expect(response.code).to eq("302")
  end

  context 'logged in user' do
    before do
      allow(controller).to receive(:current_user) { user }
    end

    it 'should create a friending if target exists' do
      expect do
        post :create, id: target.id
      end.to change(Friending, :count).by(1)
    end

    it 'should not create a friending if target does not exist' do
      expect do
        post :create, id: target.id + 2
      end.to change(Friending, :count).by(0)
    end

    it 'should delete the friending' do
      create(:friending, user: user, friend: target)
      expect do
        delete :destroy, id: target.id
      end.to change(Friending, :count).by(-1)
    end
  end

  context 'logged out user' do

    it 'should not create a friending if not logged in' do
      expect do
        post :create, id: target.id
      end.to change(Friending, :count).by(0)
    end

    it 'should not delete the friending if not logged in' do
      create(:friending, user: user, friend: target)
      expect do
        delete :destroy, id: target.id
      end.to change(Friending, :count).by(0)
    end
  end


end
