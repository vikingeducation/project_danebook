require 'rails_helper'

include UserAuth

describe TimelinesController do
  describe 'showing a timeline' do

    let(:user){ create(:user) }

    before do
      sign_me_in(user)
    end

    describe "GET #show" do

      it "works as normal" do
        get :show, user_id: user.id
        expect(response).to render_template :show
      end

      it "doesn't show for a visitor" do
        sign_me_out
        get :show, user_id: user.id
        expect(response).to redirect_to(login_path)
      end
    end

  end

end