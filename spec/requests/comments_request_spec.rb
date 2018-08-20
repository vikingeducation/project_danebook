require 'rails_helper'

describe 'CommentsRequests' do


  describe 'User Access' do

    let(:user){ create(:user) }
    let(:user_profile){ create(:profile, user_id: user.id) }
    let(:user_post){ create(:post, user_id: user.id) }
    let(:user_comment){ create(:comment, user_id: user.id, post_id: user_post.id) }

    before :each do
      user
      user_profile
      user_post
      post session_path, params: { email: user.email, password: user.password }
    end

    describe 'GET #index' do

      it 'works as normal when logged in' do
      end
    end

    describe 'GET #new' do
      it 'works as normal' do

      end
    end

    describe 'POST #create' do
      it 'actually creates a comment'
      it 'creates flash message'
      it 'redirects you back to timeline'
    end

    describe 'DELETE #destroy' do
      it 'actuallly deletes the comment'
      it 'creates flash message'
      it 'redirect you to timeline'
    end


  end

  describe 'Non-User Access' do
  end

end
