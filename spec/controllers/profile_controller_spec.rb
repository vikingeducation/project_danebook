require 'rails_helper'
require 'pry'


describe ProfilesController do

  let(:user){create(:user)}
  context 'logged in user' do
    before :each do
      cookies[:auth_token] = user.auth_token
    end

    it 'signed in user can view their own edit page' do
      get :edit, { user_id: user.id}

      expect(response).to render_template :edit
    end

    it 'signed in user cannot view edit page of another user' do
      other_user = create(:user)
      binding.pry
      get :edit, id: other_user.id

      expect(response).to redirect_to root_url
    end

    xit 'should raise error if user does not exist' do
      expect{get :edit, id: user.id + 1}.to raise_error(ActiveRecord::RecordNotFound)
    end

  end
end