require 'rails_helper'

describe 'PostsRequests' do
  let(:post){ create(:post) }
  let(:user){ post.user }

  context 'when user signed in' do
    before do
      allow_any_instance_of(PostsController).to receive(:current_user) { user }
    end

    # describe 'POST #create' do
    #   it "actually creates a post" do
    #     post = build(:post, user: user)
    #     expect{
    #         post user_posts_path(user), params: { post: attributes_for(:post, user: user) }
    #       }.to change(Post, :count).by(1)
    #   end
    # end #create

  #   describe 'GET #edit' do
  #     it "GET #edit redirects to sign in if no current user" do
  #       get edit_user_post_path(user, post)
  #       expect(response).to redirect_to login_path
  #     end

  #   it "for another user denies edit access"
  # end #edit

  end #when signed in

end #PostsRequests

