require 'rails_helper'

describe TimelinesController do
let(:profile) { create(:profile) }
let(:user) { create(:user, profile: profile) }

context 'signed in user' do
  before { login(user) }
  describe 'GET #show' do
    before { get :show, user_id: user }
    it "should render timeline" do
      expect(response).to render_template :show
    end
    it 'should properly set @user' do
      expect(assigns(:user)).to eq(user)
    end
  end
end
end
