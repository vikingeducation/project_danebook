require 'rails_helper'

describe User do

  describe "Validations" do 

    let(:user) { build(:user) }

    it "validates the presence of first name" do 
      is_expected.to validate_presence_of(:first_name)
    end

    it "validates the presence of a last name" do 
      is_expected.to validate_presence_of(:last_name)
    end

    it "validates the presence of an email" do 
      is_expected.to validate_presence_of(:email)
    end

    it "validates that the entered email is not taken already" do
      is_expected.to validate_uniqueness_of(:email) 
    end

    it "should have a secure password" do
      is_expected.to have_secure_password
    end

    it "should validate a minimum and maximum length for password" do 
      should validate_length_of(:password).is_at_least(5).is_at_most(20)
    end

  end

  describe "Associations" do 

    it "should accept nested attribute for a profile object" do 
      is_expected.to accept_nested_attributes_for(:profile)
    end

    it "should have many posts" do 
      is_expected.to have_many(:posts)
    end

    it "should have one profile" do 
      is_expected.to have_one(:profile)
    end

  end

  describe "#all_posts" do
    let(:user1) {build(:user)}
    it "should list all posts in ascending order of a user" do
      5.times { |n| user1.posts << build(:post, created_at: Time.now, id: n) }
      expect(user1.posts.count).to eq(5)
    end
  end

  describe "#search" do 
    it "should return an array of all matching user objects with a given search input" do
      bobs = Array.new(5) { |n| create(:user, first_name: ("Bob#{n}"), email: n )}
      search_results = User.search("Bob")
      bobs.each do |bob|
        expect(search_results).to include(bob)
      end 
    end

    it "should return an empty array of if nothing matches" do
      bobs = Array.new(5) { |n| create(:user, first_name: ("Bob#{n}"), email: n )}
      search_results = User.search("Joe")
      bobs.each do |bob|
        expect(search_results).to_not include(bob)
      end 
    end

    it "should return unique users" do 
      bobs = Array.new(1) {create(:user, first_name:"Bob") }
      bobs = bobs * 2
      search_results = User.search("Bob")
      expect(search_results.count).to eq(1)
    end

  end

end