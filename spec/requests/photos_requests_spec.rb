require "rails_helper"

describe "PhotosRequests" do
  let(:user){
    user = create(:user)
    create(:profile, user: user)
    user
  }
  let(:photo){ create(:photo, user: user) }
  let(:photo_file){ File.new("#{Rails.root}/spec/support/fixtures/image.png") }
  before do
    create(:status, :accepted)
  end

  describe "GET #index" do
    it "returns a successfull response" do
      get user_photos_path(user.id)
      expect(response.code.to_i).to be 200
    end
  end

  describe "GET #new" do
    context "logged in user" do
      ## login
      before{ post session_path, params: {email: user.email, password: user.password} }

      it "returns a successfull response" do
        get new_user_photo_path(user.id)
        expect(response.code.to_i).to be 200
      end
    end

    context "not logged in user" do
      it "redirects the user" do
        get new_user_photo_path(user.id)
        expect(response.code.to_i).to be 302
      end
    end
  end

  describe "POST #create" do
    context "logged in user" do
      ## login
      before{ post session_path, params: {email: user.email, password: user.password} }

      it "creates a new post when valid"

      it "renders the form with errors if invalid"
    end

    context "not logged in user" do
      it "redirects the user"
    end
  end

  describe "GET #show" do
    context "logged-in user" do
      it "returns a successfull response if it's the current_user or friends_with the user"

      it "redirects to root if it's not the current_user or friends_with the user"
    end

    context "not-logged-in user" do
      it "redirects to root"
    end
  end

end
