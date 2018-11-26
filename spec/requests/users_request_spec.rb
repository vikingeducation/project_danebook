require 'rails_helper'

describe 'UsersRequests' do

  describe 'User Access' do

      let(:new_user) { create(:user) }
      let(:user_profile) { create(:profile, user: new_user) }
      let(:another_user) { create(:user) }
      let(:another_profile) { create(:profile, user: another_user) }

      describe 'POST #create' do

        before :each do
          post users_path, params: { user: attributes_for(:user) }
        end

        it 'actually creates new user' do
          expect { post users_path,
                   params: { user: attributes_for(:user) } }
                   .to change(User, :count).by(1)
        end

        it 'redirects to timeline when successful' do
          expect(response).to have_http_status(:redirect)
        end

        it 'creates flash message' do
          expect(flash[:success]).not_to be_nil
        end

        it 'sets an authorization token' do
          expect(response.cookies["auth_token"]).not_to be_nil
        end

        it 'creates a new profile for user' do
          expect { post users_path, params: {
                                        user: attributes_for(:user, user_id: new_user.id,
                                                             profile: attributes_for(:profile, profile_id: user_profile.id))
                                              }
                                            }.to change(Profile, :count).by(1)

        end
      end

      describe 'PATCH #update' do

        before :each do
          post session_path, params: { email: new_user.email, password: new_user.password }
        end

        it 'actually updates user info' do
          patch user_path(new_user), params: { user: attributes_for(:user, email: "new_email@gmail.com") }
          new_user.reload
          expect(new_user.email).to eq("new_email@gmail.com")
        end

        it 'redirects if successful' do
          patch user_path(new_user), params: { user: attributes_for(:user, email: "new_email@gmail.com") }
          expect(response).to have_http_status(:redirect)
        end

        it 'renders #edit if not successful' do

          patch user_path(new_user), params: { user: attributes_for(:user, user_id: new_user.id, email: "", profile: user_profile)  }
          expect(response).to render_template('profiles/edit')
        end

        it 'creates flash message when successful' do
          patch user_path(new_user), params: { user: attributes_for(:user, email: "new_email@gmail.com") }
          expect(flash[:success]).not_to be_nil
        end

        it 'creates flash message when not successful' do
          patch user_path(new_user), params: { user: attributes_for(:user, email: "", profile: user_profile) }
          expect(flash[:danger]).not_to be_nil
        end

      end

      describe 'DELETE #destroy' do

        let(:new_post) { create(:post, user_id: new_user.id) }
        let(:another_post) { create(:post, user_id: another_user.id) }
        let(:new_photo) { create(:photo, user_id: new_user.id) }
        let(:new_comment) { create(:comment, user_id: new_user.id, commentable_id: new_post.id, commentable_type: "Post") }
        let(:another_like) { create(:like, user_id: another_user.id, likable_id: new_post.id, likable_type: "Post") }
        let(:new_like) { create(:like, user_id: new_user.id, likable_id: another_post.id, likable_type: "Post") }
        let(:new_friendship) { create(:friendship, friendee: new_user) }
        let(:another_friendship) { create(:friendship, friender: new_user) }

        before do
          new_user
          another_user
          post session_path, params: { email: new_user.email, password: new_user.password }
        end

        it 'actually destroys user' do
          expect { delete user_path(new_user) }.to change(User, :count).by(-1)
        end

        it 'creates flash message and redirects to homepage' do
          delete user_path(new_user)
          expect(flash[:success]).not_to be_nil
          expect(response).to redirect_to root_path
        end

        it 'for another user does NOT destroy' do
          expect { delete user_path(another_user) }.to change(User, :count).by(0)
        end

        it 'for another user creates flash messages and redirects' do
          delete user_path(another_user)
          expect(flash[:danger]).not_to be_nil
          expect(response).to redirect_to root_path
        end

        it 'destroys associated posts' do
          new_post
          delete user_path(new_user)
          expect { User.find(new_user.id) }.to raise_error(ActiveRecord::RecordNotFound)
          expect { Post.find(new_post.id) }.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'destroys associated photos' do
          new_photo
          delete user_path(new_user)
          expect { Photo.find(new_photo.id) }.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'destroys associated comments' do
          new_post
          new_comment
          delete user_path(new_user)
          expect { Comment.find(new_comment.id) }.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'destroys associated likes' do
          new_post
          new_like
          another_like
          delete user_path(new_user)
          expect { Like.find(new_like.id) }.to raise_error(ActiveRecord::RecordNotFound)
          expect { Like.find(another_like.id) }.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'destroys friender and friendee relationships' do
          new_user
          new_friendship
          another_friendship
          delete user_path(new_user)
          expect { Friendship.find(new_friendship.id) }.to raise_error(ActiveRecord::RecordNotFound)
          expect { Friendship.find(another_friendship.id) }.to raise_error(ActiveRecord::RecordNotFound)
        end

      end

    end

  end
