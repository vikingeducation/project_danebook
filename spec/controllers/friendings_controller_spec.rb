require 'rails_helper.rb'

describe FriendingsController do

  let(:user_1) { create(:user) }
  let(:profile_1) { create(:profile, user: user_1) }
  let(:user_2) { create(:user) }
  let(:profile_2) { create(:profile, user: user_2) }
  #let(:friending) { create(:friending, friender: user_1, friended: user_2) }

  before do
    user_1
    profile_1
    user_2
    profile_2
    create_session(user_1)
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  it "POST #create to friend another" do
    post :create, id: user_2
    expect(response).to redirect_to user_2
    expect(flash[:success]).to eq "Successfully friended #{user_2.name}"
  end

  it "POST #create to friend the same user twice" do
    create(:friending, friender: user_1, friended: user_2)
    post :create, id: user_2
    expect(response).to redirect_to user_2
    expect(flash[:danger]).to eq "Failed to friend!"
  end

  it "DELETE #destroy for existing friending" do
    create(:friending, friender: user_1, friended: user_2)
    delete :destroy, id: user_2.id
    expect(response).to redirect_to "where_i_came_from"
    expect(flash[:success]).to eq "Successfully unfriended"
  end

  it "DELETE #destroy for nonexisting friending" do
    delete :destroy, id: user_2.id
    expect(response).to redirect_to user_path(user_1)
    expect(flash[:danger]).to eq "Failed to unfriend"
  end
end
