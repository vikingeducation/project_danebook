require 'rails_helper'

describe 'UsersRequests' do
  # let(:post){ create(:post) }
  # let(:user){ post.user }
  let(:user){ build(:user) }

  describe 'GET #index' do
    it "redirects visitors on log in" do
      get users_path
      # expect(response).to_not be_success
      expect(response).to redirect_to login_path
    end

    xit "functions as normal for logged-in users" do
      user = create(:user)
      request.session[:user_id] = user.id
      get users_path
      expect(response).to be_success
    end
  end #index

  # describe 'GET #show' do
  #   it "GET #show works as normal" do
  #     get user_path(user)
  #     expect(response).to be_success
  #   end
  # end #show

  # describe 'GET #new' do
  #   it "GET #new redirects to sign in if no current user" do
  #     get new_user_path
  #     expect(response).to redirect_to new_session_path
  #   end
  # end #new

  # describe 'POST #create' do
  #   it "actually creates a post" do
  #     post session_path, params: { email: user.email, password: user.password }
  #     expect{
  #         post users_path, params: { post: attributes_for(:post), params: {user_id: user.id} }
  #       }.to change(Secret, :count).by(1)
  #   end
  # end #create

  # describe 'GET #edit' do
  #   it "GET #edit redirects to sign in if no current user" do
  #     get edit_user_path(user)
  #     expect(response).to redirect_to new_session_path
  #   end

  #   it "for another user denies edit access"
  # end #edit

end #UsersRequests
