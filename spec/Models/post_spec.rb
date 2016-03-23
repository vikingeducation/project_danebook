
require 'rails_helper'

describe Post do

  let(:default_post){ build(:post) }

  let(:default_user){ build(:user) }

  describe 'default_post' do 

    it "is valid with default attributes" do
      expect(default_post).to be_valid
    end

    it "is an Post instance" do
      expect(default_post).to be_a Post
    end

  end

  describe 'default post saved values' do   

    it "has body attribute set" do
      default_post.save!
      expect(default_post.body).to be_truthy
    end

  end

  describe 'checks post body' do   
    #let(:user_x){ create(:user) }

    it "to not nil" do
      new_post = build(:post, body: nil)
      expect(new_post).to_not be_valid
    end

    it "to not contain only spaces" do
      new_post = build(:post, body: "    ")
      expect(new_post).to_not be_valid
    end

  end

  describe 'responds to association' do
    
    it "user association" do
      expect(default_post).to respond_to(:user)
    end
 
    it "likes association" do
      expect(default_post).to respond_to(:likes)
    end

    it "liked_by_users association" do
      expect(default_post).to respond_to(:liked_by_users)
    end

    it "comments association" do
      expect(default_post).to respond_to(:comments)
    end

  end


  describe 'user post ' do
    
    it "can be many per user" do
      
      default_user.save!

      posts = create_list(:post, 10, user_id: default_user.id)
      expect(default_user.posts.count).to eq(10)
    end


    it "is always related to a valid user" do
      
      default_user = create(:user)

      post_one = create(:post)
      post_one.user_id = 12345
      expect(post_one).to_not be_valid
    end

  end
end