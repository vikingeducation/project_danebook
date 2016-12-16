require 'rails_helper'
# spec/controllers/users_controller_spec.rb

describe UsersController do
  let(:profile){ create(:profile)}
  let(:user){ profile.user }
  let(:another){create(:user)}

  before do
    another
    user
  end

  context "authenticated" do
    describe 'user access' do

      before :each do
        create_session(user)
      end

      describe "#set_user" do

      end

      describe 'GET #index' do

        it "renders the :index template" do
          process :index
          assert_response :success
        end

      end

      describe 'GET #new' do

        it "GET #new redirects to index" do
          process :new
          expect(response).to redirect_to users_path
        end

      end

      describe 'GET #edit' do
        it "allows viewing the edit page" do
          process :edit, params: {id: user.id }
          assert_response :success
        end

        it "does not allow viewing another user's edit page" do
          process :edit, params: {id: another.id }
          assert_response :redirect
        end
      end

      describe 'POST #update' do

        it_has_behavior 'valid_update', :user, { current_password: "!23456Yuiopasdf", email: "foo@email.com" }, :user_path do
          let(:checked) { user }
        end

        it_has_behavior 'invalid_update', :user, { email: "new@email.com" } do
          let(:checked) { user }
        end

        it_has_behavior 'unauthorized_update', :user, { current_password: "!23456Yuiopasdf", email: "foo@email.com" } do
          let(:checked) { another }
        end
      end

    end

  end

  describe 'GET #new' do

    it "does not require authentication" do
      process :new
      assert_response :success
    end

  end

  describe 'POST #create' do

    it_has_behavior 'valid_create', :user, :users_path, 1

    it_has_behavior 'invalid_create', :user, { user: {
                                                  email: "newemail.com",
                                                  password: "asdf"
                                                  }
                                                }

  end
end
