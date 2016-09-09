require 'rails_helper'

describe UsersController do
  let(:user) { create(:user) }
  let(:post) {create(:post, :author => user)}

  before :each do
    cookies[:auth_token] = user.auth_token
  end




  # describe "GET #edit" do
  #   it "for this user works as normal" do
  #     get :edit, :id => user.id
  #     expect(response).to render_template :about_edit
  #   end
  #
  #   it "for another user denies access" do
  #     another_user = create(:user)
  #     get :edit, :id => another_user.id
  #     expect(response).to redirect_to root_url
  #   end
  # end
  #
  # describe "PATCH #update" do
  #
  #     before { user }
  #
  #     context "with valid attributes" do
  #
  #       let(:updated_name){ "updated_foo" }
  #
  #       # let's make sure the ID parameter works
  #       it "finds the specified user" do
  #         put :update, :id => user.id,
  #                       :user => attributes_for(:user,
  #                                               :name => updated_name)
  #         expect(assigns(:user)).to eq(user)
  #       end
  #
  #       it "redirects to the updated user" do
  #         put :update, :id => user.id,
  #                       :user => attributes_for(:user,
  #                                               :name => updated_name)
  #
  #         expect(response).to redirect_to user_path(assigns(:user))
  #       end
  #
  #       it "actually updates the user" do
  #         put :update, :id => user.id,
  #                       :user => attributes_for(:user,
  #                                               :name => updated_name)
  #
  #         user.reload
  #         expect(user.name).to eq(updated_name)
  #       end
  #     end
  #
  #     context "with invalid attributes" do
  #       it "for another user denies access" do
  #         another_user = create(:user)
  #         get :update, :id => another_user.id,
  #                         :user => attributes_for(:user)
  #         expect(response).to redirect_to root_url
  #       end
  #     end
  #   end
  #
  # describe "GET #show" do
  #   it "creates teh appropriate instance variable" do
  #
  #     get :show, :id => user.id
  #
  #
  #     expect(assigns(:user)).to eq(user)
  #   end
  # end
  #
  # describe "DELETE #destroy" do
  #
  #     before { user }  # force let to evaluate
  #   context "with valid attributes" do
  #     it "destroys the user" do
  #       expect{
  #         delete :destroy, :id => user.id
  #       }.to change(User, :count).by(-1)
  #     end
  #
  #     it "redirects to the root" do
  #       delete :destroy, :id => user.id
  #       expect(response).to redirect_to users_url
  #     end
  #   end
  #
  #   context "with invalid attributes" do
  #     it "for another user denies access" do
  #       another_user = create(:user)
  #       delete :destroy, :id => another_user.id
  #       expect(response).to redirect_to root_url
  #     end
  #
  #   end
  # end



end
