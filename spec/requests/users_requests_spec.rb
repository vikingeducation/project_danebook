require "rails_helper"

describe "UsersRequests" do
  let(:user) do
    user = create(:user)
    create(:profile, user: user)
    user
  end
  before{ create(:status, :accepted)}

  describe "GET #show" do
    it "returns a successfull response if the user exists" do
      get user_path(user.id)
      expect(response.code.to_i).to be 200
    end

    it "raises an error if the users does not exist" do
      expect{
        get user_path(user.id + 1)
      }.to raise_error(ActionView::Template::Error)
    end
  end

  describe "GET #new" do
    it "returns a successfull response" do
      get new_user_path
      expect(response.code.to_i).to be 200
    end
  end

  describe "POST #create" do
    let(:good_user_params){ attributes_for(:user) }

    it "creates a new user if valid" do
      expect{
        post users_path, params: {user: good_user_params}
      }.to change(User, :count).by(1)
    end

    it "redirects to posts#index if valid" do
      post users_path, params: {user: good_user_params}
      expect(response.code.to_i).to be 302
    end

    it "re-renders the form with errors if invalid" do
      post users_path, params: {user: {email: nil}}
      expect(response.code.to_i).to be 200
    end
  end

  describe "GET #edit" do
    # login
    before{ post session_path, params: {email: user.email, password: user.password}}

    it "returns a successfull response if it's the same user" do
      get edit_user_path(user.id)
      expect(response.code.to_i).to be 200
    end

    it "it redirects to the root path if it's not the same user" do
      other_user = create(:user)
      get edit_user_path(other_user.id)
      expect(response.code.to_i).to be 302
    end
  end

  describe "PUT #update" do
    let(:good_user_params){ attributes_for(:user) }
    let(:bad_user_params){ {email: nil, password: nil} }
    # login
    before{ post session_path, params: {email: user.email, password: user.password}}

    context "same user" do
      it "updates the user if valid" do
        put user_path(user.id), params: {user: good_user_params}
        user.reload
        expect(user.email).to be == good_user_params[:email]
      end

      it "sets flash[:success] if valid" do
        put user_path(user.id), params: {user: good_user_params}
        expect(flash[:success]).not_to be nil
      end

      it "re-renders the form if invalid" do
        put user_path(user.id), params: {user: bad_user_params}
        expect(response.code.to_i).to be 200
      end

      it "sets flash[:danger] if invalid" do
        put user_path(user.id), params: {user: bad_user_params}
        expect(flash[:danger]).not_to be nil
      end
    end

    it "redirects to root_path if not the same user" do
      other_user = create(:user)
      put user_path(other_user.id), params: {user: good_user_params}
      other_user.reload
      expect(response.code.to_i).to be 302
      expect(other_user.email).not_to be == good_user_params[:email]
    end
  end

  describe "GET #search" do
    it "returns a successful response" do
      get users_search_path
      expect(response.code.to_i).to be 200
    end
  end

end
