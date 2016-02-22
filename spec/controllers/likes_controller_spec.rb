require 'rails_helper.rb'

describe LikesController do

  let(:user) { create(:user) }
  let(:profile) { create(:profile, user: user) }
  let(:new_post) { create(:post, user: user) }
  let(:user_2) { create(:user) }
  let(:profile_2) { create(:profile, user: user_2) }
  let(:new_post_2) { create(:post, user: user_2) }

  before do
    user
    profile
    new_post
    user_2
    profile_2
    new_post_2
    create_session(user)
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  it "POST #create for a valid likeable" do
    post :create, likeable: "Post", post_id: new_post_2.id
    expect(response).to redirect_to "where_i_came_from"
    expect(flash[:success]).to eq "Like saved!"
  end

  it "POST #create for an already liked likeable" do
    create(:post_like, user: user, likeable: new_post_2)
    post :create, likeable: "Post", post_id: new_post_2.id
    expect(response).to redirect_to "where_i_came_from"
    expect(flash[:danger]).to eq "You've already liked it!"
  end

  it "DELETE #destroy for a valid likeable" do
    new_like = create(:post_like, user: user, likeable: new_post_2)
    delete :destroy, likeable: "Post", id: new_like.id, post_id: new_post_2.id
    expect(response).to redirect_to "where_i_came_from"
    expect(flash[:success]).to eq "Post unliked!"
  end

  it "DELETE #destroy for an invalid likeable" do
    delete :destroy, likeable: "Post", id: 0, post_id: 0
    expect(response).to redirect_to user_path(user)
  end

end
