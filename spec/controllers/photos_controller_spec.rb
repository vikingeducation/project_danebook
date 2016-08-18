require 'rails_helper'

describe PhotosController do
let(:user){ create(:user) }
#create a photo for that user

  before do
    request.cookies["auth_token"] = user.auth_token
  end

  describe "POST #create" do
    xit "creates a new photo" do
    end

    xit "redirects to photos page" do
    end
  end

end
