require 'rails_helper'

describe User do

  let(:user) { build(:user) }

  describe "validations" do

    it "is valid at default" do
      expect(user).to be_valid
    end

    it { is_expected.to have_secure_password }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:gender) }
    it { is_expected.to validate_presence_of(:birthday) }

    it { expect(user).to validate_uniqueness_of(:email).case_insensitive }

    it { is_expected.to validate_length_of(:first_name)
      .is_at_least(1)
      .is_at_most(24) }
    it { is_expected.to validate_length_of(:last_name)
      .is_at_least(1)
      .is_at_most(24) }
    it { is_expected.to validate_length_of(:password)
      .is_at_least(8)
      .is_at_most(24) }


  end

  describe "associations" do

    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:comments_made) }
    it { is_expected.to have_many(:activities) }
    it { is_expected.to have_many(:comments_made) }
    it { is_expected.to have_many(:liked_things) }
    it { is_expected.to have_many(:initiated_friendings) }
    it { is_expected.to have_many(:recieved_friendings) }
    it { is_expected.to have_many(:followers) }
    it { is_expected.to have_many(:followees) }

  end

  describe "#get_wall_activities" do

    it "returns a users non commemnt activites" do
      user.save
      3.times do
        user.comments_made.create(:content => "Hello")
        user.posts.create(:content => "Hello")
      end
      expect(user.get_wall_activities.count).to eq(3)
    end

  end

  describe "#fullname" do

    it "returns the first and last name of a user seperated by a space" do
      expect(user.fullname).to eq("Fake User")
    end

  end

  describe "#current_friend?" do

    it "returns true if passed user_id is a followee" do
      new_friend = create(:user)
      user.followees << new_friend
      expect(user.current_friend?(new_friend.id)).to be true
    end

    it "returns false if passed user_id is not a followee" do
      new_friend = create(:user)
      expect(user.current_friend?(new_friend.id)).to be false
    end

    it "returns false if passed user_id does not exist" do
      expect(user.current_friend?(12345)).to be false
    end

    it "returns false if passed user_id is not an integer" do
      expect(user.current_friend?("hello friend")).to be false
    end

  end


end
