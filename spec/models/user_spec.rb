require 'rails_helper'

describe User do

  let(:user) { FactoryGirl.build(:user) }

  it 'is valid with first_name, last_name, email and password' do
    expect(user).to be_valid
  end
  it 'is invalid without email' do
    expect(FactoryGirl.build(:user, email: nil)).not_to be_valid
  end

  it 'is invalid without first_name' do
    expect(FactoryGirl.build(:user, first_name: nil)).not_to be_valid
  end

  it 'is invalid without last_name' do
    expect(FactoryGirl.build(:user, last_name: nil)).not_to be_valid
  end

  it 'is invalid without password' do
    expect(FactoryGirl.build(:user, password: nil)).not_to be_valid
  end

  it 'is invalid if password length is greater than 24' do
    expect(FactoryGirl.build(:user, password: "abcdefghijklmnopqrstuvwxy")).
           not_to be_valid
  end

  it 'is invalid if password length is less than 8' do
    expect(FactoryGirl.build(:user, password: "2short")).not_to be_valid
  end

  describe '#name' do
    it 'returns first and last name as a string' do
      expect(user.name).to eq("#{user.first_name} #{user.last_name}")
    end
  end

  describe '#posts_chronologically' do
    it 'returns a specific user\'s posts from newest to oldest'
  end


  describe 'likes?' do

    context 'if the parameter is a post' do

      it "returns true if the user has liked this post" do
        post = FactoryGirl.build(:post)
        user.liked_posts << post
        expect(user.likes?(post)).to equal true
      end

      it "returns false if the user has not liked this post" do
        post = FactoryGirl.build(:post)
        expect(user.likes?(post)).to equal false
      end

      it "returns false if the user has unliked this post" do
        user.save
        post = FactoryGirl.create(:post)
        user.liked_posts << post
        user.liked_posts.destroy(post)
        expect(user.likes?(post)).to equal false
      end
    end

    context 'if the parameter is a comment' do

      it "returns true if the user has liked this comment" do
        comment = FactoryGirl.build(:comment)
        user.liked_comments << comment
        expect(user.likes?(comment)).to equal true
      end

      it "returns false if the user has not liked this comment" do
        comment = FactoryGirl.build(:comment)
        expect(user.likes?(comment)).to equal false
      end

      it "returns false if the user has unliked this comment" do
        user.save
        comment = FactoryGirl.create(:comment)
        user.liked_comments << comment
        user.liked_comments.destroy(comment)
        expect(user.likes?(comment)).to equal false
      end

    end

    context 'if the parameter is a photo' do
      it "returns true if the user has liked this photo"
      it "returns false if the user has not liked this photo"
      it "returns false if the user has unliked this photo"
    end
  end



end