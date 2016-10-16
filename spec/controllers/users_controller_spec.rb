require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    it 'creates a new user' do
      expect{
        process :create, method: :post, params: {:user => attributes_for(:user)}
      }.to change(User, :count).by(1)
      expect(response).to redirect_to about_user_path(assigns(:user))
    end

    it "create fails with wrong params" do
      expect{
        process :create, method: :post, params: {:user => attributes_for(:user, :email => "") }
      }.to change(User, :count).by(0)
      expect(response).to render_template :new
    end
  end

  describe 'GET #timeline' do
    let(:profile){ create(:profile) }
    let(:user){ profile.user }
    let(:post){ create(:post) }
    before :each do
      user.update(auth_token: "oETdNFrK3PCCdJdPsDbF1g")
      request.cookies["auth_token"] = user.auth_token
    end
    it 'display timeline' do
      process :timeline, method: :get, params: {:id => user.id}
      expect(assigns(:post)).to be_kind_of(Post)
      expect(assigns(:comment)).to be_kind_of(Comment)
      expect(assigns(:posts)).to eq([post])
      expect(response).to have_http_status(200)
      expect(response).to render_template :timeline
    end
  end
end
