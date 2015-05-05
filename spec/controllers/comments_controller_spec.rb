require 'rails_helper'

describe CommentsController do
  let(:user){ FactoryGirl.create(:user) }
  let(:user_post){ FactoryGirl.create(:post) }
  let(:photo){ FactoryGirl.create(:photo) }
  let(:photo_comment){ FactoryGirl.create(:photo_comment) }
  let(:post_comment){ FactoryGirl.create(:photo_comment) }



  context 'user logged in' do
    before(:each) do
      @current_user = FactoryGirl.create(:user)
      cookies[:auth_token] = @current_user.auth_token

    end

    describe 'POST #create' do
      before do
        # stub out redirect for set_return_path
        allow(request).to receive(:referer).and_return(root_path)
      end

      context 'with a comment on a post' do
        before(:each) do
          post :create, { user_id: user_post.user.id,
                          post_id: user_post.id,
                          commentable: "Post",
                          comment: { body: "Foo such Bar Wowww" } }
        end


        it 'should properly assign the parent object' do
          expect(assigns(:commentable)).to eq user_post
        end

        it 'should create a comment on the post' do
          expect(assigns(:comment).commentable).to eq user_post
        end

        it "should set the new comment's author as the current user" do
          expect(assigns(:comment).user).to eq controller.current_user
        end

        it 'should redirect to the referring page' do
          expect(response).to redirect_to request.referer
        end
      end

      context 'with a comment on a photo' do
        before(:each) do
          post :create, { user_id: photo.user.id,
                          photo_id: photo.id,
                          commentable: "Photo",
                          comment: { body: "Foo such Bar Wowww" } }
        end

        it 'should properly assign the parent object' do
          expect(assigns(:commentable)).to eq photo
        end

        it 'should create a comment on the photo' do
          expect(assigns(:comment).commentable).to eq photo
        end

        it "should set the new comment's author as the current user" do
          expect(assigns(:comment).user).to eq controller.current_user
        end

        it 'should redirect to the referring page' do
          expect(response).to redirect_to request.referer
        end
      end
    end


  end





end