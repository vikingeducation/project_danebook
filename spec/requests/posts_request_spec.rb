require 'rails_helper'

describe 'PostsRequests' do
  let(:post){ create(:post) }
  let(:user){ post.user }

  describe 'GET #new' do
    it "GET #new redirects to sign in if no current user" do
      get new_user_post_path(user)
      expect(response).to redirect_to login_path
    end
  end #new

  # describe 'POST #create' do
  #   it "actually creates a post" do
  #     post user_post_path(user), params: { email: user.email, password: user.password }
  #     expect{
  #         post posts_path, params: { post: attributes_for(:post), params: {user_id: user.id} }
  #       }.to change(Secret, :count).by(1)
  #   end
  # end #create

  # describe 'GET #edit' do
  #   it "GET #edit redirects to sign in if no current user" do
  #     get edit_post_path(post)
  #     expect(response).to redirect_to new_session_path
  #   end

  #   it "for another user denies edit access"
  # end #edit

end #PostsRequests

