require 'rails_helper'

describe CommentsController do
  let(:user) { create(:user) }
  let(:text_post) { user.text_posts.create(description: "post text") }
  let(:photo_post) { user.photo_posts.create(description: "photo text") }
  let(:comment) { create(:comment, user: user, commentable: photo_post) }


  before do
    set_http_referer
  end

  # ----------------------------------------
  # POST #create
  # ----------------------------------------


  describe 'POST #create' do
    let(:post_create_valid) do
      post :create,
        comment: {
          description: "comment description",
          commentable_type: text_post.class.to_s,
          commentable_id: text_post.id
        }
    end
    let(:post_create_invalid) do
      post :create,
        comment: {
          description: "",
          commentable_type: text_post.class.to_s,
          commentable_id: 0
        }
    end


    context 'the user is NOT logged in' do
      it 'does not create the comment' do
        expect { post_create_valid }.to change(Comment, :count).by(0)
      end

      it 'redirects to login' do
        post_create_valid
        expect(response).to redirect_to(login_path)
      end
    end


    context 'the user IS logged in' do
      context 'the data is valid' do
        before do
          create_session(user)
        end


        it 'creates the comment' do
          expect { post_create_valid }.to change(Comment, :count).by(1)
        end


        it 'sets a success flash message' do
          post_create_valid
          expect(flash[:success]).to_not be_nil
        end


        it 'redirects back' do
          post_create_valid
          expect(response).to redirect_to(:back)
        end
      end


      context 'the data is invalid' do
        before do
          create_session(user)
        end

        it 'does not create the comment' do
          expect { post_create_invalid }.to change(Comment, :count).by(0)
        end


        it 'sets an error flash' do
          post_create_invalid
          expect(flash[:error]).to_not be_nil
        end


        it 'redirects to back' do
          post_create_invalid
          expect(response).to redirect_to(:back)
        end
      end
    end
  end


  # ----------------------------------------
  # DELETE #destroy
  # ----------------------------------------

  describe 'DELETE #destroy' do
    let(:delete_destroy_valid) { delete :destroy, :id => comment.id }
    let(:delete_destroy_invalid) { delete :destroy, :id => 0 }


    before do
      comment
    end


    context 'the user IS logged in' do
      before do
        create_session(user)
      end

      context 'when valid' do
        it 'destroys the comment' do
          expect { delete_destroy_valid }.to change(Comment, :count).by(-1)
        end


        it 'sets a success flash' do
          delete_destroy_valid
          expect(flash[:success]).to_not be_nil
        end
      end


      context 'when invalid' do
        it 'does NOT destroy the comment' do
          expect { delete_destroy_invalid }.to change(Comment, :count).by(0)
        end


        it 'sets a error flash' do
          delete_destroy_invalid
          expect(flash[:error]).to_not be_nil
        end
      end
    end


    context 'the user is NOT logged in' do
      it 'does NOT destroy the comment' do
        expect { delete_destroy_valid }.to change(Comment, :count).by(0)
      end


      it 'redirects to login' do
        delete_destroy_valid
        expect(response).to redirect_to(login_path)
      end


      it 'sets an error flash' do
        delete_destroy_valid
        expect(flash[:error]).to_not be_nil
      end
    end
  end
end
