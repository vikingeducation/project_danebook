require 'rails_helper'
require 'pry'

describe 'LikesRequests' do

  let(:user){create(:user)}
  let(:profile){create(:profile, :user_id => user.id)}
  let(:old_post){create(:post, :user_id => user.id)}
  let(:old_like){create(:post_like)}

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

    before do
      old_like
      Post.all.each do |post|
        post.likes.create(attributes_for(:post_like, :user_id => user.id))
      end
      Like.all
      binding.pry
    end

    it "unlikes" do
      expect{ delete likes_path, params: { :like => {:likeable_id => old_post.id, :likeable_type => "#{Post.name}" } } }.to change(Like, :count).by(-1)
    end

    it "destroying post, will destroy the like also" do
      expect{ delete user_post_path(user, Post.last.id) }.to change(Like, :count).by(-1)
    end
  end


end
