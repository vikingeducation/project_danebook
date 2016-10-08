require 'rails_helper'

describe PostsController do
  let(:user) { create(:user) }
  let(:text_post) { user.text_posts.create(description: "test post") }

  before do
    set_http_referer
  end

  # ----------------------------------------
  # POST #create
  # ----------------------------------------

  describe 'POST #create' do
    let(:post_create_valid) do
      post :create,
           post: {
             description: "valid description"
           }
    end

    let(:post_create_invalid) do
      post :create,
        post: { description: nil }
    end


    context 'the user is logged in' do
      before do
        create_session(user)
      end

      context 'the data is valid' do
        it 'creates the user' do
          expect { post_create_valid }.to change(Post, :count).by(1)
        end

        it 'redirects to the user' do
          post_create_valid
          expect(response).to redirect_to :back
        end


        it 'sets a success flash' do
          post_create_valid
          expect(flash[:success]).to_not be_nil
        end
      end


      context 'the data is invalid' do
        it 'does NOT create the user' do
          expect { post_create_invalid }.to change(Post, :count).by(0)
        end


        it 'renders the new template' do
          post_create_invalid
          expect(response).to redirect_to :back
        end


        it 'sets an error flash' do
          post_create_invalid
          expect(flash[:error]).to_not be_nil
        end
      end
    end


    context 'the user IS NOT logged in' do
      before do
        post_create_invalid
      end

      it 'redirects to root path' do
        expect(response).to redirect_to login_path
      end

      it 'sets an error flash' do
        expect(flash[:error]).to_not be_nil
      end
    end
  end

  # ----------------------------------------
  # DELETE #destroy
  # ----------------------------------------

  describe 'DELETE #destroy' do
    let(:delete_destroy_valid) { delete :destroy, id: text_post.id }
    let(:delete_destroy_invalid) { delete :destroy, id: 0 }

    before do
      text_post
    end

    context 'the user is logged in' do
      before do
        create_session(user)
      end

      context 'when valid' do
        it 'destroys the playlist selection' do
          expect { delete_destroy_valid }.to change(Post, :count).by(-1)
        end


        it 'sets a success flash' do
          delete_destroy_valid
          expect(flash[:success]).to_not be_nil
        end
      end


      context 'when invalid' do
        it 'does NOT destroy the playlist selection' do
          expect { delete_destroy_invalid }.to change(Post, :count).by(0)
        end


        it 'sets a error flash' do
          delete_destroy_invalid
          expect(flash[:error]).to_not be_nil
        end
      end

    end

    context 'the user IS NOT logged in' do
      it 'does NOT destroy the playlist selection' do
        expect { delete_destroy_valid }.to change(Post, :count).by(0)
      end


      it 'redirects to login' do
        delete_destroy_valid
        expect(response).to redirect_to login_path
      end


      it 'sets an error flash' do
        delete_destroy_valid
        expect(flash[:error]).to_not be_nil
      end
    end
  end
end
