require 'rails_helper'

include UserAuth

describe ProfilesController do
  describe 'user profile' do

    let(:user){ create(:user) }

    before do
      sign_me_in(user)
    end

    describe "GET #show" do

      it "works as normal" do
        get :show, user_id: user.id
        expect(response).to render_template :show
      end

    end

  end

end