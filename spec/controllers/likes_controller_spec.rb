require 'rails_helper'

describe LikesController do
  let(:user) { create(:user) }
  let(:text_post) { user.text_posts.create(description: " test psot") }
  let(:photo_post) { user.photo_posts.create }
  let(:post_like) { create(:post_like, user: user, :likeable => text_post) }
  let(:photo_like) { create(:photo_like, user: user, :likeable => photo_post) }


  before do
    set_http_referer
  end

  # ----------------------------------------
  # POST #create
  # ----------------------------------------
  # describe 'POST #create' do
  #   let(:post_create_valid) do
  #     post :create,
  #       :likeable_type => photo_post.class.to_s,
  #       :likeable_id => photo_post.id
  #   end
  #   let(:post_create_invalid) do
  #     post :create,
  #       :likeable_type => photo_post.class.to_s,
  #       :likeable_id => 0
  #   end
  #
  #
  #   context 'the user is NOT logged in' do
  #     it 'does not create the like' do
  #       expect { post_create_valid }.to change(Like, :count).by(0)
  #     end
  #
  #     it 'redirects to login' do
  #       post_create_valid
  #       expect(response).to redirect_to(login_path)
  #     end
  #   end
  #
  #
  #   context 'the user IS logged in' do
  #     context 'the data is valid' do
  #       before do
  #         create_session(user)
  #       end
  #
  #
  #       it 'creates the like' do
  #         expect { post_create_valid }.to change(Like, :count).by(1)
  #       end
  #
  #
  #       it 'sets a success flash message' do
  #         post_create_valid
  #         expect(flash_success).to_not be_nil
  #       end
  #
  #
  #       it 'redirects back' do
  #         post_create_valid
  #         expect(response).to redirect_to(:back)
  #       end
  #     end
  #
  #
  #     context 'the data is invalid' do
  #       before do
  #         create_session(user)
  #       end
  #
  #       it 'does not create the like' do
  #         expect { post_create_invalid }.to change(Like, :count).by(0)
  #       end
  #
  #
  #       it 'sets an error flash' do
  #         post_create_invalid
  #         expect(flash_error).to_not be_nil
  #       end
  #
  #
  #       it 'redirects to back' do
  #         post_create_invalid
  #         expect(response).to redirect_to(:back)
  #       end
  #     end
  #   end
  # end
end
