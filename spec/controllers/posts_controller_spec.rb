require 'rails_helper'

describe PostsController do
  let(:author){ create(:user) }
  let(:created_post){ create(:post) }

  context 'user not logged in' do
    it 'redirects to login path' do
      post :create, params: { user_id: author.id, post: attributes_for(:post) }
      expect(response).to redirect_to login_path
    end
  end

  context 'user logged in' do
    before do
      cookies[:auth_token] = author.auth_token
      post :create, params: { user_id: author.id, post: attributes_for(:post) }
    end

    it 'redirects to user timeline' do
      expect(response).to redirect_to user_timeline_path(author)
    end

    it 'displays flash messages' do
      expect(flash[:success]).not_to be_nil
    end
  end
end