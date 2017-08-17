require 'rails_helper'
require 'pry'

describe 'LikesRequests' do

  let(:user){create(:user)}
  let(:profile){create(:profile, :user_id => user.id)}
  let(:old_post){create(:post, :user_id => user.id)}

  before do
    user
    profile
    old_post 
    login_as(user)
  end

  describe "POST #create" do
    it "likes post with with successfull flash messsage" do

      post likes_path, params: { :like => {:likeable_id => old_post.id, :likeable_type => "#{Post.name}" } }
      expect(flash[:success]).to_not be_nil
    end

    it "actually creates the like" do
      expect{ post likes_path, params: { :like => {:likeable_id => old_post.id, :likeable_type => "#{Post.name}" } } }.to change(Like, :count).by(1)
    end
  end

  describe "DELETE #destroy" do

    let(:new_post){create(:post, :user_id => user.id)}

    before do
      new_post
      new_post.likes.create(attributes_for(:post_like, :user_id => user.id))
      old_post.likes.create(attributes_for(:post_like, :user_id => user.id))
    end

    it "unlikes" do
      expect{ delete likes_path, params: { :like => {:likeable_id => old_post.id, :likeable_type => "#{Post.name}" } } }.to change(Like, :count).by(-1)
    end

    it "destroying post, will destroy the like also" do
      expect{ delete user_post_path(user, new_post.id) }.to change(Like, :count).by(-1)
    end
  end


end
