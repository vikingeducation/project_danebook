require 'rails_helper'

RSpec.describe NewsfeedsController, type: :controller do


  describe 'GET #show' do

    context "current user's newsfeed" do

      let(:user) { create(:user) }
      let(:friend) { create(:user) }

      before do
        request.cookies[:auth_token] = user.auth_token
        user.friended_users << friend
      end


      it { should use_before_action(:require_login) }


      it 'assigns @user to current user' do
        get :show
        expect(assigns[:user]).to eq(user)
      end


      it 'collects latest posts from friends into @posts' do
        posts = create_list(:post, 2, :poster_id => friend.id)

        # dummy post that should not be pulled
        create(:post)

        get :show

        expect(assigns[:posts].size).to eq(2)
        expect(posts).to include(assigns[:posts].first)
      end


      it 'renders the show template' do
        get :show
        should render_template('show')
      end


      it 'collects recently active friends into @friends' do
        user.friended_users << create(:user)
        create(:post, :poster_id => user.friended_users.first.id)
        create(:post, :poster_id => user.friended_users.last.id)

        # dummy user that should not be pulled in as a friend
        create(:user)

        get :show

        expect(assigns[:friends].size).to eq(2)
        expect(user.friended_users).to include(assigns[:friends].first)
      end


      it 'does not include duplicated users in @friends' do
        user.friended_users << create(:user)
        create(:post, :poster_id => user.friended_users.first.id)
        2.times { create(:post, :poster_id => user.friended_users.last.id) }

        # dummy user that should not be pulled in as a friend
        create(:user)

        get :show

        expect(assigns[:friends].size).to eq(2)
        expect(user.friended_users).to include(assigns[:friends].last)
      end

    end


    context "when not logged in" do

      it "prevents viewing any newsfeed" do
        get :show
        expect(flash[:danger]).to eq("You must be logged in to do this.")
        expect(response).to redirect_to(login_path)
      end

    end


  end

end
