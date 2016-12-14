require 'rails_helper'
# spec/controllers/users_controller_spec.rb

describe UsersController do
  let(:profile){ create(:profile)}
  let(:user){ profile.user }

  before do
    user
  end

  context "authenticated" do
    describe 'user access' do

      before :each do
        create_session(user)
      end

      describe 'GET #index' do

        it "renders the :index template" do
          get :index
          assert_response :success
        end

      end

      describe 'GET #new' do

        it "GET #new redirects to index" do
          get :new
          expect(response).to redirect_to users_path
        end

      end

    end

  end

  describe 'GET #new' do

    it "does not require authentication" do
      get :new
      assert_response :success
    end

  end

  describe 'POST #create' do

    it "creates a new user and redirects to the index page on success" do
      expect{process :create, method: :post, params: {
                                                      user: {
                                                              email: "new@email.com",
                                                              password: user.password
                                                            }
                                                      }
            }.to change(User, :count).by(1)

      expect(flash[:success]).to_not be_nil
      expect(flash[:danger]).to be_nil
      expect(response).to redirect_to(users_path)
    end

    it "renders the current page with errors on failure" do
      expect{process :create, method: :post, params: {
                                                      user: {
                                                              email: "newemail.com",
                                                              password: user.password
                                                            }
                                                      }
            }.to_not change(User, :count)

      expect(flash[:success]).to be_nil
      expect(flash[:danger]).to_not be_nil
      assert_response :success
    end

  end
end
