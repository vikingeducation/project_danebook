require 'rails_helper'

describe StaticPagesController do
  let(:user){ create(:user) }

  before :each do
    request.cookies['auth_token'] = user.auth_token
  end

  context "GET #new" do

    it 'does something' do
      get :new

      expect(response).to render_template :new
    end
  end
end
