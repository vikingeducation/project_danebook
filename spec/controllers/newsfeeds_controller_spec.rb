require 'rails_helper'

RSpec.describe NewsfeedsController, type: :controller do


  describe 'GET #show' do

    let(:user) { create(:user) }
    let(:friend) { create(:user) }

    before do
      request.cookies[:auth_token] = user.auth_token
      user.friended_users << friend
      get :show, :user_id => user.id
    end


    it { should use_before_action(:require_current_user) }

    it 'assigns @user to current user' do
      expect(assigns[:user]).to eq(user)
    end

    it 'collects latest posts from friends into @latest_posts' do
      posts = create_list(:post, 2, :poster_id => friend.id)

      # dummy post that should not be pulled
      create(:post)

      expect(assigns[:latest_posts].size).to eq(2)
      expect(posts).to include(assigns[:latest_posts].first)
    end

  end

end
