require 'rails_helper'

describe 'PostsRequests' do

  let(:user){create(:user)}
  let(:profile){create(:profile, :user_id => user.id)}
  let(:old_post){create(:post, :user_id => user.id)}

  before do
    user
    profile
    login_as(user)
  end

  describe "POST #create" do
    it "publish new post with sufficietn flash messsage" do
      post user_posts_path(user), params: { :post => {:body => "New body", :user_id => user.id} }
      expect(flash[:success]).to_not be_nil
    end 

    it "actually creates the post" do
     expect{ post user_posts_path(user), params: { :post => { :body => "New body",
                                                              :user_id => user.id } } }.to change(Post, :count).by(1)
    end
  end

  describe "DELETE #destroy" do

    before { old_post }

    it "deletes published post" do
      expect{ delete user_post_path(user, old_post.id) }.to change(Post, :count).by(-1)
    end
  end

end
