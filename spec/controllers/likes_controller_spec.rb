require 'rails_helper'


describe LikesController do

  let(:user){create(:user)}

  before :each do
    cookies[:auth_token] = user.auth_token
    user.posts = create_list(:post, 1)
    @post= user.posts.first
    allow(controller).to receive(:store_referer).
                        and_return(session[:referer] = user_posts_path(user.id))
  end

  context 'logged in user' do

    describe 'POST #create' do

      it 'user can like a post' do

        expect do
          post :create, like: attributes_for(:post_like,
                                            user_id:      user.id,
                                            likings_id:   @post.id,
                                            likings_type: "Post")

        end.to change(Like, :count).by(1)
      end

      it 'redirects to index/refreshes after liking something' do
        post :create, like: attributes_for(:post_like,
                                            user_id:      user.id,
                                            likings_id:   @post.id,
                                            likings_type: "Post")
        expect(response).to redirect_to (user_posts_path(user.id))
      end

      it "can create a like on another user's timeline" do
        another_user = create(:user)
        expect do
          post :create, like: attributes_for(:post_like,
                                              user_id:      user.id,
                                              likings_id:   @post.id,
                                              likings_type: "Post")

        end.to change(Like, :count).by(1)
      end

      it "cannot like something you already liked" do
        first_like = create(:post_like, user_id: user.id, likings_id:   @post.id, likings_type: "Post")

        expect do
          post :create, like: attributes_for(:post_like,
                                              user_id:      user.id,
                                              likings_id:   @post.id,
                                              likings_type: "Post")
        end.to change(Like, :count).by(0)
      end

    end

    # describe 'DELETE #destroy' do

    #   xit 'can unlike' do
    #     first_like = create(:post_like, user_id: user.id, likings_id:   @post.id, likings_type: "Post")
    #     binding.pry
    #     expect do
    #       delete :destroy, first_like.attributes
    #       binding.pry
    #     end.to change(Like, :count).by(-1)
    #   end

    # end

  end
end