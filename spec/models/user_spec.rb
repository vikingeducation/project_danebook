require 'rails_helper'

describe User do

  let(:user) { FactoryGirl.build(:user) }




  describe '.new' do

    it 'is valid with first_name, last_name, email and password' do
      expect(user).to be_valid
    end
    it 'is invalid without email' do
      expect(FactoryGirl.build(:user, email: nil)).not_to be_valid
    end

    it 'is invalid with a non-unique email' do
      FactoryGirl.create(:user, email: "blahblah@blah.com")
      ripoff = FactoryGirl.build(:user, email: "blahblah@blah.com")
      expect(ripoff).not_to be_valid
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

  end




  describe '.search' do
    let!(:george){ FactoryGirl.create(:user, first_name: "George", last_name: "Costanza")}

    it 'finds users with first names matching the query' do
      expect(User.search("George")).to include(george)
    end

    it 'is not case sensitive' do
      expect(User.search("george")).to include(george)
    end

    it 'finds users with last names matching the query' do
      expect(User.search("costanza")).to include(george)
    end

    it 'finds a user by first name and last name' do
      expect(User.search("george costanza")).to include(george)
    end

    it 'finds a user by partial first name' do
      expect(User.search("geo")).to include(george)
    end

    it 'finds a user by partial last name' do
      expect(User.search("cost")).to include(george)
    end

    it 'finds a user by partial first and last name' do
      expect(User.search("rge ostanz")).to include(george)
    end

    it 'does not find a user if their name is not in the query' do
      george.destroy
      expect(User.search("George")).not_to include(george)
    end

  end





  describe '#name' do
    it 'returns first and last name as a string' do
      expect(user.name).to eq("#{user.first_name} #{user.last_name}")
    end
  end




  describe '#posts_chronologically' do
    it 'returns a specific user\'s posts from newest to oldest' do
      #passing time does the trick here
      user.save
      oldest = FactoryGirl.create(:post, user_id: user.id )
      middle = FactoryGirl.create(:post, user_id: user.id )
      newest = FactoryGirl.create(:post, user_id: user.id )

      expect(user.posts_chronologically).to eq([newest, middle, oldest])

    end
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
        expect(user.likes?(FactoryGirl.build(:comment))).to equal false
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
      it "returns true if the user has liked this photo" do
        photo = FactoryGirl.build(:photo)
        user.liked_photos << photo
        expect(user.likes?(photo)).to equal true
      end

      it "returns false if the user has not liked this photo" do
        expect(user.likes?(FactoryGirl.build(:photo))).to equal false
      end

      it "returns false if the user has unliked this photo" do
        user.save
        photo = FactoryGirl.create(:photo)
        user.liked_photos << photo
        user.liked_photos.destroy(photo)
        expect(user.likes?(photo)).to equal false
      end
    end
  end



  describe '#has_friend?' do
    let(:other_user) { FactoryGirl.create(:user) }

    it 'returns true if a user has this friend' do
      user.friends << other_user
      expect(user.has_friend?(other_user)).to equal true
    end

    it 'returns true if a user does not have this friend' do
      expect(user.has_friend?(other_user)).not_to equal true
    end
  end


end